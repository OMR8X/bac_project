import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/services/router/app_routes.dart';

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
    _controller = WebViewController();
    if (widget.notification.html?.isNotEmpty ?? false) {
      //
      _controller.loadHtmlString(widget.notification.html!);
      //
      _controller.setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) async {
            return NavigationDecision.navigate;
          },
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: Center(child: WebViewWidget(controller: _controller)),
    );
  }
}
