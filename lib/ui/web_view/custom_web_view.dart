import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'dart:developer' as devtools show log;

class CustomWebView extends HookWidget {
  const CustomWebView({
    super.key,
    required this.initialUrl,
    this.gesturesEnabled = false,
    this.onLoadStop,
    this.onTap,
  });

  final String initialUrl;
  final bool gesturesEnabled;
  final Function? onLoadStop;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    final webViewKey = useMemoized(() => GlobalKey());
    final webViewController = useState<InAppWebViewController?>(null);
    final options = useMemoized(
      () => InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        ),
        ios: IOSInAppWebViewOptions(
          allowsInlineMediaPlayback: true,
        ),
      ),
    );
    final pullToRefreshController = useMemoized(() => PullToRefreshController(
          options: PullToRefreshOptions(
            color: Colors.green,
          ),
          onRefresh: () {
            webViewController.value?.reload();
          },
        ));

    void disableActions() async {
      // TODO: Disable clicks on all elements in the WebView content
    }

    return Stack(
      children: [
        InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
          initialOptions: options,
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            webViewController.value = controller;
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url;

            if (![
              "http",
              "https",
              "file",
              "chrome",
              "data",
              "javascript",
              "about"
            ].contains(uri?.scheme)) {
              return NavigationActionPolicy.CANCEL;
            }

            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            pullToRefreshController.endRefreshing();

            if (!gesturesEnabled) disableActions();
            onLoadStop != null ? onLoadStop!() : null;
          },
          onLoadError: (controller, url, code, message) {
            pullToRefreshController.endRefreshing();
            devtools.log("Error $code: $message");
          },
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer()
                ..onDown = (value) {
                  onTap != null ? onTap!() : null;
                },
            )
          },
        ),
      ],
    );
  }
}
