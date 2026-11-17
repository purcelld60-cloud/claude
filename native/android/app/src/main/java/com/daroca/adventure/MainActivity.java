package com.daroca.adventure;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.view.WindowManager;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import androidx.webkit.WebViewAssetLoader;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Collections;

/**
 * Da Roça Adventure: abre o jogo (pasta dist/, embutida em assets) num WebView em tela cheia.
 * Os arquivos são servidos por https://appassets.androidplatform.net, uma origem fixa,
 * então o progresso salvo (localStorage) continua entre aberturas e o jogo funciona sem internet.
 * Modo TV (Fase 8): o app também liga o TvServer na rede Wi-Fi. Os celulares abrem
 * http://IP-DA-TV:PORTA no navegador e viram controles; o jogo na tela fala com ele em ws://127.0.0.1.
 */
public class MainActivity extends Activity {
    private static final String HOST = "appassets.androidplatform.net";
    private static final String HOME = "https://" + HOST + "/assets/dist/index.html?native=1";
    private WebView web;
    private TvServer tvServer;
    private int tvPort = 0;
    private final Handler ticker = new Handler(Looper.getMainLooper());
    private final Runnable tick = new Runnable() {
        @Override public void run() {
            if (tvServer != null) new Thread(() -> { try { tvServer.tick(); } catch (Exception ignored) { } }).start();
            ticker.postDelayed(this, 15000);
        }
    };

    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

        final WebViewAssetLoader loader = new WebViewAssetLoader.Builder()
                .addPathHandler("/assets/", new WebViewAssetLoader.AssetsPathHandler(this))
                .build();

        startTvServer();

        web = new WebView(this);
        web.setBackgroundColor(0xFF000000);
        setContentView(web);

        WebSettings s = web.getSettings();
        s.setJavaScriptEnabled(true);
        s.setDomStorageEnabled(true);
        s.setMediaPlaybackRequiresUserGesture(false);
        s.setAllowFileAccess(false);
        s.setAllowContentAccess(false);
        s.setCacheMode(WebSettings.LOAD_DEFAULT);
        // o jogo (https://appassets...) conversa com o servidor da TV em ws://127.0.0.1
        s.setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);

        web.setWebViewClient(new WebViewClient() {
            @Override
            public WebResourceResponse shouldInterceptRequest(WebView view, WebResourceRequest request) {
                return loader.shouldInterceptRequest(request.getUrl());
            }

            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                Uri uri = request.getUrl();
                if (HOST.equals(uri.getHost())) return false;
                try {
                    startActivity(new Intent(Intent.ACTION_VIEW, uri));
                } catch (Exception ignored) { }
                return true;
            }
        });
        web.setWebChromeClient(new WebChromeClient());

        if (state != null) web.restoreState(state);
        else web.loadUrl(homeUrl());
    }

    /** Liga o servidor da TV numa porta livre (8787 a 8797). Se não der, o jogo segue sem o modo TV. */
    private void startTvServer() {
        for (int port = 8787; port <= 8797 && tvServer == null; port++) {
            try {
                TvServer srv = new TvServer(getAssets(), port);
                srv.startServer();
                tvServer = srv;
                tvPort = port;
            } catch (Exception ignored) { }
        }
        if (tvServer != null) ticker.postDelayed(tick, 15000);
    }

    /** Endereço IPv4 da TV na rede local (Wi-Fi ou cabo), para os celulares acharem o servidor. */
    private static String lanAddress() {
        try {
            String fallback = "";
            for (NetworkInterface ni : Collections.list(NetworkInterface.getNetworkInterfaces())) {
                if (!ni.isUp() || ni.isLoopback()) continue;
                for (InetAddress a : Collections.list(ni.getInetAddresses())) {
                    if (!(a instanceof Inet4Address) || a.isLoopbackAddress()) continue;
                    String ip = a.getHostAddress();
                    if (a.isSiteLocalAddress()) {
                        String n = ni.getName();
                        if (n.startsWith("wlan") || n.startsWith("eth")) return ip;
                        if (fallback.isEmpty()) fallback = ip;
                    }
                }
            }
            return fallback;
        } catch (Exception e) {
            return "";
        }
    }

    private String homeUrl() {
        if (tvServer == null) return HOME;
        return HOME + "&tvport=" + tvPort + "&tvip=" + lanAddress();
    }

    private void immersive() {
        getWindow().getDecorView().setSystemUiVisibility(
                View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                        | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                        | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                        | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                        | View.SYSTEM_UI_FLAG_FULLSCREEN
                        | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY);
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        if (hasFocus) immersive();
    }

    @Override
    protected void onResume() {
        super.onResume();
        web.onResume();
        immersive();
    }

    @Override
    protected void onPause() {
        web.onPause();
        super.onPause();
    }

    @Override
    protected void onSaveInstanceState(Bundle out) {
        super.onSaveInstanceState(out);
        web.saveState(out);
    }

    @Override
    @SuppressWarnings("deprecation")
    public void onBackPressed() {
        if (web.canGoBack()) web.goBack();
        else super.onBackPressed();
    }

    @Override
    protected void onDestroy() {
        ticker.removeCallbacks(tick);
        if (tvServer != null) {
            try { tvServer.stop(); } catch (Exception ignored) { }
            tvServer = null;
        }
        if (web != null) {
            web.destroy();
            web = null;
        }
        super.onDestroy();
    }
}
