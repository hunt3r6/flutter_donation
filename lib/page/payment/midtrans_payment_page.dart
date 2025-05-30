import 'package:flutter/material.dart';
import 'package:flutter_donation/core/constants/app_config.dart';
import 'package:flutter_donation/core/widget/custom_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MidtransPaymentPage extends StatefulWidget {
  final String snapToken;
  const MidtransPaymentPage({super.key, required this.snapToken});

  @override
  State<MidtransPaymentPage> createState() => _MidtransPaymentPageState();
}

class _MidtransPaymentPageState extends State<MidtransPaymentPage> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) {
                // Cek jika URL adalah sukses atau gagal, lakukan sesuatu
                if (url.contains('/success')) {
                  context.pop('success');
                } else if (url.contains('/failure')) {
                  context.pop('failure');
                } else if (url.contains('transaction_status=settlement')) {
                  context.pop('Payment Success');
                } else if (url.contains('transaction_status=expire')) {
                  context.pop('Payment Expired');
                } else if (url.contains('transaction_status=cancel')) {
                  context.pop('Payment Canceled');
                } else if (url.contains('transaction_status=deny')) {
                  context.pop('Payment Denied');
                }
              },
            ),
          )
          ..loadRequest(Uri.parse(AppConfig.urlPayment + widget.snapToken));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Midtrans Payment',
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
