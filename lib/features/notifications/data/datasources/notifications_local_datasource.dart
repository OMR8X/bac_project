import 'package:bac_project/core/services/cache/cache_manager.dart';
import 'package:bac_project/features/notifications/data/mappers/app_notification_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/app_notification.dart';
import '../models/app_notification_model.dart';

abstract class NotificationsLocalDatasource {
  ///
  Future<List<AppNotification>> getNotifications();

  ///
  Future<Unit> clearNotifications();

  ///
  Future<int> insertNotification({required AppNotification notification});

  ///
  Future<int> deleteNotification({required int notificationId});
}

class NotificationsLocalDatasourceImplements implements NotificationsLocalDatasource {
  ///
  final CacheManager _cacheManager;

  NotificationsLocalDatasourceImplements(this._cacheManager);
  @override
  Future<int> insertNotification({required AppNotification notification}) async {
    //
    // final int id = await _cacheManager.write(
    //   'notifications_table',
    //   notification.toModel.toDatabaseJson(),
    // );
    //
    return 0;
  }

  @override
  Future<int> deleteNotification({required int notificationId}) async {
    //
    // final int id = await _database.delete(
    //   "notifications_table",
    //   where: "id = ?",
    //   whereArgs: [notificationId],
    // );
    return 0;
  }

  @override
  Future<List<AppNotification>> getNotifications() async {
    //
    // await _database.update('notifications_table', {"seen": 1});
    //
    // List<Map<String, dynamic>> operationsJson = await _cacheManager.read(
    //   'notifications_table',
    //   orderBy: "date DESC",
    // );
    //
    // List<AppNotification> operations =
    //     operationsJson.map((data) {
    //       return AppNotificationModel.fromDatabaseJson(data).toEntity;
    //     }).toList();

    return [];
  }

  @override
  Future<Unit> clearNotifications() async {
    //
    // await _database.delete('notifications_table');
    //
    return unit;
  }
}
