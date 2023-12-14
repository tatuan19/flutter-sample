import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sample/common/widgets/custom_app_bar.dart';
import 'package:sample/ui/web_view/custom_web_view.dart';

import 'dart:developer' as devtools show log;

@RoutePage()
class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final url = "${dotenv.get('CLIENT_BASE_URL')}/1on1/reservation";
    final cookieManager = CookieManager.instance();

    return Scaffold(
      appBar: const CustomAppBar(title: Text('店舗で参加')),
      body: Stack(
        children: [
          CustomWebView(
            initialUrl: url,
            onLoadStop: () async {
              await cookieManager
                  .getCookie(url: Uri.parse(url), name: "_couplink_sess")
                  .then((cookie) => devtools.log(cookie?.value ?? ""));
            },
          )
        ],
      ),
    );
  }
}
