import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive/hive.dart';
import 'package:sample/common/constants/local_data_keys.dart';
import 'package:sample/common/themes/sizes.dart';
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
      body: CustomWebView(
        initialUrl: url,
        onLoadStop: () async {
          cookieManager
              .getCookie(url: Uri.parse(url), name: "_couplink_sess")
              .then((cookies) {
            final sessionId = cookies?.value;

            if (sessionId != null && sessionId.isNotEmpty) {
              devtools.log('sessionId: $sessionId');
              Hive.box(localDataBox).put(sessionIdKey, sessionId);
            }
          }).catchError((error) {
            devtools.log('error: $error');
          });
        },
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return RequireLoginDialog(
                onPositivePressed: () {},
                onNegativePressed: () {},
                onRedirect: () {},
              );
            },
          );
        },
      ),
    );
  }
}

class RequireLoginDialog extends StatelessWidget {
  const RequireLoginDialog({
    super.key,
    required this.onPositivePressed,
    required this.onNegativePressed,
    required this.onRedirect,
  });

  final VoidCallback onPositivePressed;
  final VoidCallback onNegativePressed;
  final VoidCallback onRedirect;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'ここから先は、\n会員登録が必要です',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            '会員登録は120秒で完了します',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: FontSize.small),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onPositivePressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              foregroundColor: Colors.white,
            ),
            child: const Text(
              '会員登録に進む',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            onPressed: onNegativePressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[400],
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'キャンセル',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onRedirect,
            child: const Text(
              '会員の方はこちら',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontSize.tiny,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
