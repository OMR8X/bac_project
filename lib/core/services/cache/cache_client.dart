import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'cache_constant.dart';

abstract class CacheClient {
  /// initiate client
  Future<void> init(Directory appDir);

  /// initiate client
  Future<void> refresh(Directory appDir);

  /// check if key exist in cache
  Future<bool> exist(String key);

  /// write to cache
  Future<void> write(String key, dynamic data);

  /// read from cache
  Future<dynamic> read(String key);

  /// read all values from cache
  Future<dynamic> values();

  /// clear data of the passed key from cache
  Future<void> remove(String key);

  /// clear all data in cache
  Future<void> clear();
  //
  Future<void> close();
}

class HiveClient implements CacheClient {
  /// initiate hive box
  @override
  Future<void> init(Directory appDir) async {
    await Hive.initFlutter(appDir.path + CacheConstant.cacheSubDir);
    return;
  }

  @override
  Future<void> refresh(Directory appDir) async {
    await close();
    await init(appDir);
    return;
  }

  /// check if key exist in cache
  @override
  Future<bool> exist(String key) async {
    final box = await openHiveBox(CacheConstant.boxName);
    final value = (box).containsKey(key);

    return value;
  }

  /// write to hive box
  @override
  Future<void> write(String key, dynamic data) async {
    final box = await openHiveBox(CacheConstant.boxName);
    await box.put(key, data);

    return;
  }

  /// read from hive box
  @override
  Future<dynamic> read(String key) async {
    final box = await openHiveBox(CacheConstant.boxName);
    final data = await box.get(key);
    return data;
  }

  /// read all values from hive box
  @override
  Future<dynamic> values() async {
    final box = await Hive.openBox(CacheConstant.boxName);
    final data = (box).values.toList();

    return data;
  }

  /// clear data of the passed key from hive box
  @override
  Future<void> remove(String key) async {
    final box = await Hive.openBox(CacheConstant.boxName);
    await (box).delete(key);
  }

  /// clear all data
  @override
  Future<void> clear() async {
    await Hive.deleteFromDisk();
  }

  @override
  Future<void> close() async {
    await Hive.close();
  }

  Future<Box> openHiveBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    return await Hive.openBox(boxName);
  }
}
