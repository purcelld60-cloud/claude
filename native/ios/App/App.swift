// Da Roça Adventure para iOS: uma janela de navegador (WKWebView) em tela cheia que
// carrega o jogo da pasta dist/ embutida no app. Funciona sem internet e o progresso
// fica salvo no aparelho, como no site.
import UIKit
import WebKit

/// Entrega os arquivos de dist/ pelo endereço daroca://jogo/..., com suporte a pedidos
/// parciais (Range), que o iOS exige para tocar áudio.
final class BundleSchemeHandler: NSObject, WKURLSchemeHandler {
    private let root: URL
    private static let mime: [String: String] = [
        "html": "text/html; charset=utf-8", "js": "text/javascript; charset=utf-8", "mjs": "text/javascript; charset=utf-8",
        "css": "text/css; charset=utf-8", "json": "application/json; charset=utf-8", "svg": "image/svg+xml",
        "png": "image/png", "jpg": "image/jpeg", "jpeg": "image/jpeg", "gif": "image/gif", "webp": "image/webp",
        "ico": "image/x-icon", "ttf": "font/ttf", "otf": "font/otf", "woff": "font/woff", "woff2": "font/woff2",
        "mp3": "audio/mpeg", "ogg": "audio/ogg", "wav": "audio/wav", "m4a": "audio/mp4", "mp4": "video/mp4",
        "txt": "text/plain; charset=utf-8", "webmanifest": "application/manifest+json"
    ]

    init(root: URL) { self.root = root.standardizedFileURL }

    func webView(_ webView: WKWebView, start task: WKURLSchemeTask) {
        guard let url = task.request.url else { task.didFailWithError(URLError(.badURL)); return }
        var path = url.path
        if path.isEmpty || path.hasSuffix("/") { path += "index.html" }
        let file = root.appendingPathComponent(String(path.dropFirst())).standardizedFileURL
        guard file.path.hasPrefix(root.path + "/"), let data = try? Data(contentsOf: file) else {
            respond(task, url: url, status: 404, headers: ["Content-Type": "text/plain"], body: Data())
            return
        }
        var headers = [
            "Content-Type": BundleSchemeHandler.mime[file.pathExtension.lowercased()] ?? "application/octet-stream",
            "Accept-Ranges": "bytes",
            "Cache-Control": "no-cache"
        ]
        if let range = task.request.value(forHTTPHeaderField: "Range"), let slice = BundleSchemeHandler.slice(range, total: data.count) {
            headers["Content-Range"] = "bytes \(slice.lowerBound)-\(slice.upperBound - 1)/\(data.count)"
            respond(task, url: url, status: 206, headers: headers, body: data.subdata(in: slice))
        } else {
            respond(task, url: url, status: 200, headers: headers, body: data)
        }
    }

    func webView(_ webView: WKWebView, stop task: WKURLSchemeTask) {}

    private func respond(_ task: WKURLSchemeTask, url: URL, status: Int, headers: [String: String], body: Data) {
        var all = headers
        all["Content-Length"] = String(body.count)
        guard let response = HTTPURLResponse(url: url, statusCode: status, httpVersion: "HTTP/1.1", headerFields: all) else {
            task.didFailWithError(URLError(.unknown)); return
        }
        task.didReceive(response)
        task.didReceive(body)
        task.didFinish()
    }

    /// "bytes=a-b", "bytes=a-" ou "bytes=-n" -> intervalo dentro do arquivo.
    private static func slice(_ header: String, total: Int) -> Range<Int>? {
        guard total > 0, header.hasPrefix("bytes=") else { return nil }
        let parts = header.dropFirst(6).split(separator: "-", maxSplits: 1, omittingEmptySubsequences: false)
        guard parts.count == 2 else { return nil }
        if parts[0].isEmpty {
            guard let n = Int(parts[1]), n > 0 else { return nil }
            return max(0, total - n)..<total
        }
        guard let start = Int(parts[0]), start < total else { return nil }
        let end = min(Int(parts[1]) ?? (total - 1), total - 1)
        guard end >= start else { return nil }
        return start..<(end + 1)
    }
}

final class GameViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    private var webView: WKWebView!
    private let home = URL(string: "daroca://jogo/index.html")!

    override var prefersStatusBarHidden: Bool { true }
    override var prefersHomeIndicatorAutoHidden: Bool { true }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .landscape }
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge { .all }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        let dist = Bundle.main.bundleURL.appendingPathComponent("dist", isDirectory: true)
        config.setURLSchemeHandler(BundleSchemeHandler(root: dist), forURLScheme: "daroca")
        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.scrollView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.allowsLinkPreview = false
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        webView.load(URLRequest(url: home))
    }

    // Links de fora (http/https) abrem no Safari; o jogo fica dentro do app.
    func webView(_ webView: WKWebView, decidePolicyFor action: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = action.request.url, let scheme = url.scheme?.lowercased(), scheme == "http" || scheme == "https",
           action.targetFrame?.isMainFrame ?? true {
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }

    // Se o iOS encerrar o processo da página por falta de memória, recarrega o jogo.
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) { webView.load(URLRequest(url: home)) }

    // Caixas alert / confirm / prompt usadas pelo jogo.
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in completionHandler() })
        present(alert, animated: true)
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel) { _ in completionHandler(false) })
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in completionHandler(true) })
        present(alert, animated: true)
    }

    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
        alert.addTextField { $0.text = defaultText }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel) { _ in completionHandler(nil) })
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in completionHandler(alert.textFields?.first?.text) })
        present(alert, animated: true)
    }
}

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = GameViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask { .landscape }
}
