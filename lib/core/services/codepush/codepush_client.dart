import 'package:bac_project/core/resources/errors/error_mapper.dart';
import 'package:go_router/go_router.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import '../../widgets/messages/snackbars/alert_snackbar_widget.dart';
import '../../extensions/build_context_l10n.dart';
import '../router/app_router.dart';
import '../router/routes.dart';

abstract class CodePushClient {
  Future<void> initialize();
}

class ShorebirdClient implements CodePushClient {
  final ShorebirdUpdater _updater;

  /// The track to check for updates on - must be consistent between checkForUpdate() and update()
  static const UpdateTrack _updateTrack = UpdateTrack.stable;

  ShorebirdClient([ShorebirdUpdater? updater]) : _updater = updater ?? ShorebirdUpdater();

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 5));
    try {
      ///
      final UpdateStatus status = await _getUpdateStatus();

      ///
      if (status == UpdateStatus.outdated) {
        await _onUpdate();
      }
    } catch (_) {}
  }

  Future<void> _onUpdate() async {
    try {
      await _updater.update(track: _updateTrack);
      await _sendUpdateFinishNotification();
    } catch (e) {
      await _sendUpdateErrorNotification(errorToFailure(e).message);
    }
  }

  Future<void> _sendUpdateFinishNotification() async {
    final context = AppRouter.rootNavigatorKey.currentContext;
    if (context == null) return;
    _sendNotification(
      title: context.l10n.codePushUpdateCompletedTitle,
      subtitle: context.l10n.codePushUpdateCompletedSubtitle,
    );
  }

  Future<void> _sendUpdateErrorNotification(String message) async {
    final context = AppRouter.rootNavigatorKey.currentContext;
    if (context == null) return;
    _sendNotification(title: context.l10n.codePushUpdateErrorTitle, subtitle: message);
  }

  Future<void> _sendNotification({required String title, required String subtitle}) async {
    final context = AppRouter.rootNavigatorKey.currentContext;
    if (context != null) {
      /// Don't show snackbar if user is currently quizzing or exploring notifications
      final fullPath = GoRouter.of(context).state.name;
      if (fullPath?.contains(Routes.quizzing.name) ?? false) {
        return;
      }

      showAlertSnackbar(
        context: context,
        title: title,
        subtitle: subtitle,
      );
    }
  }

  Future<UpdateStatus> _getUpdateStatus() async {
    final result = await _updater.checkForUpdate(track: _updateTrack);
    return result;
  }
}
