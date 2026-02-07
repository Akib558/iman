import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/core/services/http_service.dart';
import 'package:prayer_app/core/services/local_storage_service.dart';

// HTTP Service Provider
final httpServiceProvider = Provider<HttpService>((ref) {
  return HttpService();
});

// Storage Service Provider (expose box directly for existing code compatibility)
final storageBoxProvider = Provider((ref) {
  return LocalStorageService.box;
});
