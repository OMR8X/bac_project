import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NotificationDetailsView extends StatefulWidget {
  const NotificationDetailsView({super.key, required this.notification});
  final AppNotification notification;

  @override
  State<NotificationDetailsView> createState() => _NotificationDetailsViewState();
}

class _NotificationDetailsViewState extends State<NotificationDetailsView> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController();

    if (widget.notification.html?.isNotEmpty ?? false) {
      _controller.loadHtmlString('''
        <!DOCTYPE html>
        <html>
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style>
            body {
              font-family: 'Arial', sans-serif;
              padding: 16px;
              margin: 0;
              line-height: 1.6;
              direction: rtl;
            }
            img {
              max-width: 100%;
              height: auto;
            }
          </style>
        </head>
        <body>
          ${widget.notification.html!}
        </body>
        </html>
        ''');

      _controller.setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) async {
            // Allow navigation for better user experience
            return NavigationDecision.navigate;
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.notification.title), leading: const CloseIconWidget()),
      body:
          widget.notification.html?.isNotEmpty ?? false
              ? WebViewWidget(controller: _controller)
              : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.description_outlined, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text("لا يوجد محتوى لعرضه", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  ],
                ),
              ),
    );
  }
}
