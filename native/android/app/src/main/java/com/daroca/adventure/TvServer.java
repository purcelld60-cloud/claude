package com.daroca.adventure;

import android.content.res.AssetManager;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import fi.iki.elonen.NanoHTTPD;
import fi.iki.elonen.NanoWSD;

/**
 * Servidor da TV (Fase 8): roda dentro do app na Android TV, na rede Wi-Fi da casa.
 * - Serve a página de controle (assets/dist/controle.html) para os celulares: http://IP-DA-TV:PORTA
 * - Abre o WebSocket em /ws com o mesmo protocolo do servidor online (server/server.js):
 *   hello, create, join, leave, input (celular -> TV), state/event (TV -> celulares), ping.
 * Sem internet e sem conta: tudo fica na memória da TV e some quando o app fecha.
 * Proteções: token por celular, só o anfitrião (a TV) manda estado e avisos, limite de tamanho e de
 * mensagens, comandos conferidos.
 */
public class TvServer extends NanoWSD {
    private static final String CODE_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
    private static final SecureRandom RANDOM = new SecureRandom();
    private final AssetManager assets;
    private final Map<String, Room> rooms = new HashMap<>();
    private final Map<String, Seat> sessions = new HashMap<>();

    static final class Seat {
        String id, token, name = "Convidado", avatar = "daroca", room;
        int slot;
        Peer ws;
        long seen = System.currentTimeMillis();
        long windowStart = 0;
        int windowCount = 0;
    }

    static final class Room {
        String code, kind, hostId;
        int cap;
        final List<Seat> seats = new ArrayList<>();
    }

    public TvServer(AssetManager assets, int port) {
        super(port);
        this.assets = assets;
    }

    /* ---------------- arquivos do jogo para os celulares ---------------- */
    @Override
    protected Response serveHttp(IHTTPSession session) {
        String uri = session.getUri();
        if ("/api/health".equals(uri)) {
            return json("{\"ok\":true,\"server\":\"daroca-tv\",\"v\":1}");
        }
        if (uri == null || "/".equals(uri)) uri = "/controle.html";
        if (uri.contains("..") || uri.contains("\\")) return newFixedLengthResponse(Response.Status.FORBIDDEN, "text/plain", "proibido");
        try {
            InputStream in = assets.open("dist" + uri);
            Response r = newChunkedResponse(Response.Status.OK, mime(uri), in);
            r.addHeader("Cache-Control", "no-cache");
            return r;
        } catch (IOException e) {
            return newFixedLengthResponse(Response.Status.NOT_FOUND, "text/plain; charset=utf-8", "Não encontrado");
        }
    }

    private static Response json(String body) {
        Response r = newFixedLengthResponse(Response.Status.OK, "application/json; charset=utf-8", body);
        r.addHeader("Cache-Control", "no-store");
        r.addHeader("Access-Control-Allow-Origin", "*");
        return r;
    }

    private static String mime(String uri) {
        String u = uri.toLowerCase();
        if (u.endsWith(".html")) return "text/html; charset=utf-8";
        if (u.endsWith(".js")) return "text/javascript; charset=utf-8";
        if (u.endsWith(".css")) return "text/css; charset=utf-8";
        if (u.endsWith(".json")) return "application/json; charset=utf-8";
        if (u.endsWith(".png")) return "image/png";
        if (u.endsWith(".svg")) return "image/svg+xml";
        if (u.endsWith(".ttf")) return "font/ttf";
        if (u.endsWith(".woff2")) return "font/woff2";
        if (u.endsWith(".mp3")) return "audio/mpeg";
        return "application/octet-stream";
    }

    /* ---------------- WebSocket ---------------- */
    @Override
    protected WebSocket openWebSocket(IHTTPSession handshake) {
        return new Peer(handshake);
    }

    final class Peer extends WebSocket {
        Seat seat;

        Peer(IHTTPSession h) { super(h); }

        @Override protected void onOpen() { }

        @Override
        protected void onClose(WebSocketFrame.CloseCode code, String reason, boolean initiatedByRemote) {
            synchronized (TvServer.this) {
                if (seat != null && seat.ws == this) {
                    seat.ws = null;
                    seat.seen = System.currentTimeMillis();
                    Room r = seat.room == null ? null : rooms.get(seat.room);
                    if (r != null) broadcast(r, roomInfo(r), null);
                }
            }
        }

        @Override
        protected void onMessage(WebSocketFrame frame) {
            String text = frame.getTextPayload();
            if (text == null || text.length() > 200000) return;
            synchronized (TvServer.this) {
                try { handle(this, new JSONObject(text)); } catch (Exception ignored) { }
            }
        }

        @Override protected void onPong(WebSocketFrame pong) { }

        @Override protected void onException(IOException exception) { }

        void sendJson(JSONObject m) {
            try { send(m.toString()); } catch (IOException ignored) { }
        }
    }

    private static String randomToken() {
        byte[] b = new byte[18];
        RANDOM.nextBytes(b);
        StringBuilder s = new StringBuilder();
        for (byte x : b) s.append(String.format("%02x", x));
        return s.toString();
    }

    private String newCode() {
        for (int i = 0; i < 1000; i++) {
            StringBuilder c = new StringBuilder();
            for (int k = 0; k < 6; k++) c.append(CODE_CHARS.charAt(RANDOM.nextInt(CODE_CHARS.length())));
            if (!rooms.containsKey(c.toString())) return c.toString();
        }
        return "DAROCA";
    }

    private static String clean(String v, String def) {
        if (v == null) return def;
        String s = v.replaceAll("[<>\\u0000-\\u001f\\u007f]", "").trim();
        if (s.length() > 20) s = s.substring(0, 20);
        return s.isEmpty() ? def : s;
    }

    private static String cleanAvatar(String v) {
        return v != null && v.matches("[a-zA-Z]{2,20}") ? v : "daroca";
    }

    private JSONObject roomInfo(Room r) {
        JSONObject o = new JSONObject();
        try {
            o.put("t", "room").put("code", r.code).put("kind", r.kind).put("cap", r.cap).put("hostId", r.hostId);
            JSONArray ps = new JSONArray();
            for (Seat s : r.seats) {
                ps.put(new JSONObject().put("id", s.id).put("name", s.name).put("avatar", s.avatar).put("online", s.ws != null).put("slot", s.slot));
            }
            o.put("players", ps);
        } catch (Exception ignored) { }
        return o;
    }

    private void broadcast(Room r, JSONObject m, Seat except) {
        for (Seat s : r.seats) if (s != except && s.ws != null) s.ws.sendJson(m);
    }

    private void leave(Seat s) {
        Room r = s.room == null ? null : rooms.get(s.room);
        s.room = null;
        if (r == null) return;
        r.seats.remove(s);
        if (r.seats.isEmpty()) { rooms.remove(r.code); return; }
        if (s.id.equals(r.hostId)) {
            try { broadcast(r, new JSONObject().put("t", "error").put("m", "A TV fechou a sala.").put("end", true), null); } catch (Exception ignored) { }
            for (Seat x : r.seats) x.room = null;
            rooms.remove(r.code);
            return;
        }
        broadcast(r, roomInfo(r), null);
    }

    private void join(Seat s, Room r) throws Exception {
        if (r.seats.size() >= r.cap) { if (s.ws != null) s.ws.sendJson(new JSONObject().put("t", "error").put("m", "A sala está cheia.")); return; }
        leave(s);
        int slot = 0;
        boolean used;
        do { used = false; for (Seat x : r.seats) if (x.slot == slot) { used = true; slot++; break; } } while (used);
        s.slot = slot;
        s.room = r.code;
        r.seats.add(s);
        broadcast(r, roomInfo(r), null);
    }

    private boolean rateOk(Seat s) {
        long now = System.currentTimeMillis();
        if (now - s.windowStart > 1000) { s.windowStart = now; s.windowCount = 0; }
        return ++s.windowCount <= 150;
    }

    private void handle(Peer peer, JSONObject m) throws Exception {
        String t = m.optString("t");
        if ("hello".equals(t)) {
            String tok = m.optString("token", "");
            Seat s = tok.isEmpty() ? null : sessions.get(tok);
            if (s == null) {
                s = new Seat();
                s.id = "u" + randomToken().substring(0, 10);
                s.token = randomToken();
                sessions.put(s.token, s);
            } else if (s.ws != null && s.ws != peer) {
                try { s.ws.close(WebSocketFrame.CloseCode.NormalClosure, "outra conexão", false); } catch (Exception ignored) { }
            }
            s.ws = peer;
            peer.seat = s;
            s.name = clean(m.optString("name", null), s.name);
            if (m.has("avatar")) s.avatar = cleanAvatar(m.optString("avatar"));
            s.seen = System.currentTimeMillis();
            peer.sendJson(new JSONObject().put("t", "welcome").put("id", s.id).put("token", s.token).put("v", 1));
            Room r = s.room == null ? null : rooms.get(s.room);
            if (r != null) broadcast(r, roomInfo(r), null);
            return;
        }
        Seat s = peer.seat;
        if (s == null) return;
        if (!rateOk(s)) return;
        s.seen = System.currentTimeMillis();
        Room r = s.room == null ? null : rooms.get(s.room);
        switch (t) {
            case "ping":
                peer.sendJson(new JSONObject().put("t", "pong").put("c", m.opt("c")).put("s", System.currentTimeMillis()));
                break;
            case "create": {
                if (rooms.size() > 50) return;
                Room nr = new Room();
                nr.code = newCode();
                nr.kind = "fliperama".equals(m.optString("kind")) ? "fliperama" : "tv";
                nr.cap = Math.max(2, Math.min(8, m.optInt("cap", 5)));
                nr.hostId = s.id;
                leave(s);
                rooms.put(nr.code, nr);
                join(s, nr);
                break;
            }
            case "join": {
                Room nr = rooms.get(m.optString("code", "").toUpperCase().trim());
                if (nr == null) { peer.sendJson(new JSONObject().put("t", "error").put("m", "Sala não encontrada. Confira o código na TV.")); return; }
                join(s, nr);
                break;
            }
            case "quick": {
                Room open = null;
                for (Room x : rooms.values()) if (x.seats.size() < x.cap) { open = x; break; }
                if (open != null) join(s, open);
                else peer.sendJson(new JSONObject().put("t", "error").put("m", "Nenhuma sala aberta na TV."));
                break;
            }
            case "leave":
                leave(s);
                break;
            case "input": {
                if (r == null || s.id.equals(r.hostId)) return;
                JSONObject i = m.optJSONObject("i");
                if (i == null) return;
                int x = i.optInt("x", 0), y = i.optInt("y", 0);
                if (x < -1 || x > 1 || y < -1 || y > 1) return;
                JSONObject out = new JSONObject().put("t", "input").put("from", s.id).put("slot", s.slot).put("s", m.optLong("s", 0))
                        .put("i", new JSONObject().put("x", x).put("y", y).put("a", i.optBoolean("a", false)).put("b", i.optBoolean("b", false)));
                for (Seat h : r.seats) if (h.id.equals(r.hostId) && h.ws != null) h.ws.sendJson(out);
                break;
            }
            case "state":
                if (r != null && s.id.equals(r.hostId)) broadcast(r, new JSONObject().put("t", "state").put("s", m.opt("s")).put("d", m.opt("d")), s);
                break;
            case "event": {
                if (r == null) return;
                JSONObject e = m.optJSONObject("e");
                if (e == null || e.toString().length() > 4000) return;
                if (s.id.equals(r.hostId)) broadcast(r, new JSONObject().put("t", "event").put("e", e), s);
                else for (Seat h : r.seats) if (h.id.equals(r.hostId) && h.ws != null) h.ws.sendJson(new JSONObject().put("t", "event").put("from", s.id).put("slot", s.slot).put("e", e));
                break;
            }
            default:
                break;
        }
    }

    /** Batimento: mantém as conexões vivas e solta vagas abandonadas há mais de 60 s. */
    public synchronized void tick() {
        long now = System.currentTimeMillis();
        for (Seat s : new ArrayList<>(sessions.values())) {
            if (s.ws != null) {
                try { s.ws.ping(new byte[]{1}); } catch (Exception ignored) { }
            } else if (now - s.seen > 60000) {
                leave(s);
                sessions.remove(s.token);
            }
        }
    }

    public void startServer() throws IOException {
        start(0, true); // sem tempo limite de leitura: o WebSocket fica aberto durante a partida
    }

    /** Usado só para deixar claro de onde vem o mime padrão do NanoHTTPD. */
    static String version() { return NanoHTTPD.class.getSimpleName(); }
}
