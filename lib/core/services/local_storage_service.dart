import 'package:hive_flutter/hive_flutter.dart';
import 'package:prayer_app/core/constants/app_constants.dart';
import 'package:prayer_app/core/utils/exceptions.dart';
import 'package:prayer_app/core/utils/logger.dart';

class LocalStorageService {
  LocalStorageService._();

  static Box? _box;

  static Box get box {
    if (_box == null || !_box!.isOpen) {
      throw const StorageException('Storage box is not initialized');
    }
    return _box!;
  }

  static Future<void> init() async {
    try {
      await Hive.initFlutter();
      _box = await Hive.openBox(AppConstants.storageBoxName);
      Logger.info('LocalStorageService initialized');
    } catch (e, stackTrace) {
      Logger.error('Failed to initialize storage', e, stackTrace);
      throw StorageException('Failed to initialize storage', originalError: e);
    }
  }

  static T? get<T>(String key) {
    try {
      return box.get(key) as T?;
    } catch (e) {
      Logger.warning('Failed to get value for key: $key', e);
      return null;
    }
  }

  static Future<void> put(String key, dynamic value) async {
    try {
      await box.put(key, value);
    } catch (e, stackTrace) {
      Logger.error('Failed to save value for key: $key', e, stackTrace);
      throw StorageException('Failed to save data', originalError: e);
    }
  }

  static Future<void> delete(String key) async {
    try {
      await box.delete(key);
    } catch (e, stackTrace) {
      Logger.error('Failed to delete value for key: $key', e, stackTrace);
      throw StorageException('Failed to delete data', originalError: e);
    }
  }

  static Future<void> clear() async {
    try {
      await box.clear();
    } catch (e, stackTrace) {
      Logger.error('Failed to clear storage', e, stackTrace);
      throw StorageException('Failed to clear storage', originalError: e);
    }
  }

  static bool containsKey(String key) {
    return box.containsKey(key);
  }

  static List<String> getAllKeys() {
    return box.keys.cast<String>().toList();
  }
}
