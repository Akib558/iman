import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/features/tasbih/data/dhikr_repository.dart';
import 'package:prayer_app/features/tasbih/domain/dhikr.dart';
import 'package:prayer_app/features/tasbih/domain/tasbih_count.dart';

// Repository Provider
final dhikrRepositoryProvider = Provider<DhikrRepository>((ref) {
  return DhikrRepository();
});

// Dhikr List Provider
final dhikrListProvider = StateNotifierProvider<DhikrListNotifier, List<Dhikr>>((ref) {
  final repository = ref.watch(dhikrRepositoryProvider);
  return DhikrListNotifier(repository);
});

class DhikrListNotifier extends StateNotifier<List<Dhikr>> {
  final DhikrRepository _repository;

  DhikrListNotifier(this._repository) : super([]) {
    _loadDhikrs();
  }

  void _loadDhikrs() {
    state = _repository.getAllDhikrs();
  }

  Future<void> addDhikr(Dhikr dhikr) async {
    await _repository.addDhikr(dhikr);
    _loadDhikrs();
  }

  Future<void> updateDhikr(int index, Dhikr dhikr) async {
    await _repository.updateDhikr(index, dhikr);
    _loadDhikrs();
  }

  Future<void> deleteDhikr(int index) async {
    await _repository.deleteDhikr(index);
    _loadDhikrs();
  }
}

// Tasbih Counter Provider
final tasbihCounterProvider = StateNotifierProvider.family<TasbihCounterNotifier, TasbihCount, String>(
  (ref, dhikrId) => TasbihCounterNotifier(dhikrId),
);

class TasbihCounterNotifier extends StateNotifier<TasbihCount> {
  TasbihCounterNotifier(String dhikrId)
      : super(TasbihCount(dhikrId: dhikrId, count: 0));

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }

  void reset() {
    state = state.copyWith(count: 0);
  }
}
