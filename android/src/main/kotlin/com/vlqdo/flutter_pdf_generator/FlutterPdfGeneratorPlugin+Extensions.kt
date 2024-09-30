package com.vlqdo.flutter_pdf_generator


import android.annotation.SuppressLint
import android.os.Handler
import android.os.Looper
import android.print.PdfPrint
import android.webkit.WebView
import android.webkit.WebViewClient
import io.flutter.plugin.common.MethodChannel.Result

@SuppressLint("SetJavaScriptEnabled")
fun FlutterPdfGeneratorPlugin.createWebView(content: String): WebView {
    val webView = WebView(activity.applicationContext)
    val width = this.activity.window.windowManager.defaultDisplay.width
    val height = this.activity.window.windowManager.defaultDisplay.height
    webView.layout(0, 0, width, height)
    webView.loadDataWithBaseURL(null, content, "text/html", "UTF-8", null)
    return webView
}

@SuppressLint("SetJavaScriptEnabled")
fun FlutterPdfGeneratorPlugin.configureWebView(webView: WebView) {
    with(webView.settings) {
        javaScriptEnabled = true
        useWideViewPort = true
        javaScriptCanOpenWindowsAutomatically = true
        loadWithOverviewMode = true
    }
    WebView.enableSlowWholeDocumentDraw()
}

fun FlutterPdfGeneratorPlugin.setupWebViewClient(
    webView: WebView,
    savedPath: String?,
    format: Map<String, Double>?,
    footerText: String?,
    headerText: String?,
    duration: Double,
    result: Result
) {
    webView.webViewClient = object : WebViewClient() {
        override fun onPageFinished(view: WebView, url: String) {
            super.onPageFinished(view, url)

            Handler(Looper.getMainLooper()).postDelayed({
                webView.exportAsPdfFromWebView(savedPath!!, format!!, footerText, headerText, object : PdfPrint.CallbackPrint {
                    override fun success(path: String) {
                        result.success(path)
                    }

                    override fun onFailure() {
                        result.success(null)
                    }
                })
            }, duration.toLong())
        }
    }
}
