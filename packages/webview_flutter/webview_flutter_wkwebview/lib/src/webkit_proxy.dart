// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:typed_data';

import 'common/platform_webview.dart';
import 'common/web_kit.g.dart';

/// Handles constructing objects and calling static methods for the Darwin
/// WebKit native library.
///
/// This class provides dependency injection for the implementations of the
/// platform interface classes. Improving the ease of unit testing and/or
/// overriding the underlying Darwin classes.
///
/// By default each function calls the default constructor of the class it
/// intends to return.
class WebKitProxy {
  /// Constructs an [WebKitProxy].
  const WebKitProxy({
    this.newURLRequest = URLRequest.new,
    this.newWKUserScript = WKUserScript.new,
    this.newHTTPCookie = HTTPCookie.new,
    this.newAuthenticationChallengeResponse =
        AuthenticationChallengeResponse.new,
    this.newWKWebViewConfiguration = WKWebViewConfiguration.new,
    this.newWKScriptMessageHandler = WKScriptMessageHandler.new,
    this.newWKNavigationDelegate = WKNavigationDelegate.new,
    this.newNSObject = NSObject.new,
    this.newPlatformWebView = PlatformWebView.new,
    this.newWKUIDelegate = WKUIDelegate.new,
    this.newUIScrollViewDelegate = UIScrollViewDelegate.new,
    this.createAsyncAuthenticationChallengeResponse =
        AuthenticationChallengeResponse.createAsync,
    this.withUserAsyncURLCredential = URLCredential.withUserAsync,
    this.serverTrustAsyncURLCredential = URLCredential.serverTrustAsync,
    this.withUserURLCredential = URLCredential.withUser,
    this.evaluateWithErrorSecTrust = SecTrust.evaluateWithError,
    this.copyExceptionsSecTrust = SecTrust.copyExceptions,
    this.setExceptionsSecTrust = SecTrust.setExceptions,
    this.getTrustResultSecTrust = SecTrust.getTrustResult,
    this.copyCertificateChainSecTrust = SecTrust.copyCertificateChain,
    this.copyDataSecCertificate = SecCertificate.copyData,
    this.defaultDataStoreWKWebsiteDataStore =
        _defaultDataStoreWKWebsiteDataStore,
  });

  /// Constructs [URLRequest].
  final URLRequest Function({required String url}) newURLRequest;

  /// Constructs [WKUserScript].
  final WKUserScript Function({
    required String source,
    required UserScriptInjectionTime injectionTime,
    required bool isForMainFrameOnly,
  }) newWKUserScript;

  /// Constructs [HTTPCookie].
  final HTTPCookie Function(
      {required Map<HttpCookiePropertyKey, Object> properties}) newHTTPCookie;

  /// Constructs [AuthenticationChallengeResponse].
  final AuthenticationChallengeResponse Function({
    required UrlSessionAuthChallengeDisposition disposition,
    URLCredential? credential,
  }) newAuthenticationChallengeResponse;

  /// Constructs [WKWebViewConfiguration].
  final WKWebViewConfiguration Function() newWKWebViewConfiguration;

  /// Constructs [WKScriptMessageHandler].
  final WKScriptMessageHandler Function({
    required void Function(
      WKScriptMessageHandler,
      WKUserContentController,
      WKScriptMessage,
    ) didReceiveScriptMessage,
  }) newWKScriptMessageHandler;

  /// Constructs [WKNavigationDelegate].
  final WKNavigationDelegate Function({
    void Function(
      WKNavigationDelegate,
      WKWebView,
      String?,
    )? didFinishNavigation,
    void Function(
      WKNavigationDelegate,
      WKWebView,
      String?,
    )? didStartProvisionalNavigation,
    required Future<NavigationActionPolicy> Function(
      WKNavigationDelegate,
      WKWebView,
      WKNavigationAction,
    ) decidePolicyForNavigationAction,
    required Future<NavigationResponsePolicy> Function(
      WKNavigationDelegate,
      WKWebView,
      WKNavigationResponse,
    ) decidePolicyForNavigationResponse,
    void Function(
      WKNavigationDelegate,
      WKWebView,
      NSError,
    )? didFailNavigation,
    void Function(
      WKNavigationDelegate,
      WKWebView,
      NSError,
    )? didFailProvisionalNavigation,
    void Function(
      WKNavigationDelegate,
      WKWebView,
    )? webViewWebContentProcessDidTerminate,
    required Future<AuthenticationChallengeResponse> Function(
      WKNavigationDelegate,
      WKWebView,
      URLAuthenticationChallenge,
    ) didReceiveAuthenticationChallenge,
  }) newWKNavigationDelegate;

  /// Constructs [NSObject].
  final NSObject Function(
      {void Function(
        NSObject,
        String?,
        NSObject?,
        Map<KeyValueChangeKey, Object?>?,
      )? observeValue}) newNSObject;

  /// Constructs [PlatformWebView].
  final PlatformWebView Function({
    required WKWebViewConfiguration initialConfiguration,
    void Function(
      NSObject,
      String?,
      NSObject?,
      Map<KeyValueChangeKey, Object?>?,
    )? observeValue,
  }) newPlatformWebView;

  /// Constructs [WKUIDelegate].
  final WKUIDelegate Function({
    void Function(
      WKUIDelegate,
      WKWebView,
      WKWebViewConfiguration,
      WKNavigationAction,
    )? onCreateWebView,
    required Future<PermissionDecision> Function(
      WKUIDelegate,
      WKWebView,
      WKSecurityOrigin,
      WKFrameInfo,
      MediaCaptureType,
    ) requestMediaCapturePermission,
    Future<void> Function(
      WKUIDelegate,
      WKWebView,
      String,
      WKFrameInfo,
    )? runJavaScriptAlertPanel,
    required Future<bool> Function(
      WKUIDelegate,
      WKWebView,
      String,
      WKFrameInfo,
    ) runJavaScriptConfirmPanel,
    Future<String?> Function(
      WKUIDelegate,
      WKWebView,
      String,
      String?,
      WKFrameInfo,
    )? runJavaScriptTextInputPanel,
  }) newWKUIDelegate;

  /// Constructs [UIScrollViewDelegate].
  final UIScrollViewDelegate Function({
    void Function(
      UIScrollViewDelegate,
      UIScrollView,
      double,
      double,
    )? scrollViewDidScroll,
  }) newUIScrollViewDelegate;

  /// Calls to [AuthenticationChallengeResponse.createAsync].
  final Future<AuthenticationChallengeResponse> Function(
    UrlSessionAuthChallengeDisposition disposition,
    URLCredential? credential,
  ) createAsyncAuthenticationChallengeResponse;

  /// Calls to [URLCredential.withUserAsync].
  final Future<URLCredential> Function(
    String,
    String,
    UrlCredentialPersistence,
  ) withUserAsyncURLCredential;

  /// Calls to [URLCredential.serverTrustAsync].
  final Future<URLCredential> Function(SecTrust) serverTrustAsyncURLCredential;

  /// Constructs [URLCredential].
  final URLCredential Function({
    required String user,
    required String password,
    required UrlCredentialPersistence persistence,
  }) withUserURLCredential;

  /// Calls to [SecTrust.evaluateWithError].
  final Future<bool> Function(SecTrust) evaluateWithErrorSecTrust;

  /// Calls to [SecTrust.copyExceptions].
  final Future<Uint8List?> Function(SecTrust) copyExceptionsSecTrust;

  /// Calls to [SecTrust.setExceptions].
  final Future<bool> Function(SecTrust, Uint8List?) setExceptionsSecTrust;

  /// Calls to [SecTrust.getTrustResult].
  final Future<GetTrustResultResponse> Function(SecTrust)
      getTrustResultSecTrust;

  /// Calls to [SecTrust.copyCertificateChain].
  final Future<List<SecCertificate>?> Function(SecTrust)
      copyCertificateChainSecTrust;

  /// Calls to [SecCertificate.copyData].
  final Future<Uint8List> Function(SecCertificate) copyDataSecCertificate;

  /// Calls to [WKWebsiteDataStore.defaultDataStore].
  final WKWebsiteDataStore Function() defaultDataStoreWKWebsiteDataStore;

  static WKWebsiteDataStore _defaultDataStoreWKWebsiteDataStore() =>
      WKWebsiteDataStore.defaultDataStore;
}
