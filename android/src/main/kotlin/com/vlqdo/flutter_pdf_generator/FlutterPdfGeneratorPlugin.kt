package com.vlqdo.flutter_pdf_generator

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.webkit.WebView
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterPdfGeneratorPlugin */
class FlutterPdfGeneratorPlugin: FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

  private lateinit var channel : MethodChannel
  private lateinit var webView: WebView
  lateinit var activity: Activity

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_pdf_generator")
    channel.setMethodCallHandler(this)
  }

  @SuppressLint("SetJavaScriptEnabled")
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    handleMethodCall(call, result)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    webView = WebView(activity.applicationContext)
    webView.minimumHeight = 1
    webView.minimumWidth = 1
  }

  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {}

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun handleMethodCall(
    call: MethodCall,
    result: Result
  ) {
    val method = call.method

    when (method) {
      "convertHtmlToPdf" -> {
        val arguments = call.arguments as Map<*, *>
        val content = arguments["content"] as String
        val footerText = arguments["footerText"] as String?
        val headerText = arguments["headerText"] as String?
        var duration = arguments["duration"] as Double?
        val savedPath = arguments["savedPath"] as? String
        val format = arguments["format"] as Map<String, Double>?
        if (duration == null) duration = 2000.00

        webView = createWebView(content)
        configureWebView(webView)
        setupWebViewClient(webView, savedPath, format, footerText, headerText, duration, result)
      }
      else -> result.notImplemented()
    }
  }
}
