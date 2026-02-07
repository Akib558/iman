import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/features/names/data/names_repository.dart';
import 'package:prayer_app/features/names/domain/allah_name.dart';

// Repository Provider
final namesRepositoryProvider = Provider<NamesRepository>((ref) {
  return NamesRepository();
});

// Names List Provider
final allahNamesProvider = Provider<List<AllahName>>((ref) {
  final repository = ref.watch(namesRepositoryProvider);
  return repository.getAllNames();
});

// Selected Name Provider (for detail view if needed)
final selectedNameProvider = StateProvider<AllahName?>((ref) => null);
