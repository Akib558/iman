import 'package:prayer_app/core/constants/app_constants.dart';
import 'package:prayer_app/core/services/local_storage_service.dart';
import 'package:prayer_app/features/tasbih/domain/dhikr.dart';

class DhikrRepository {
  static const List<Map<String, dynamic>> _defaultDhikrs = [
    {
      "id": "1",
      "dhikir": "Alhamdulillah",
      "arabic": "الحمد لله",
      "translationEn": "Praise is to Allah (SWT).",
      "translationBn": "",
    },
    {
      "id": "2",
      "dhikir": "SubhanAllah",
      "arabic": "سبحان الله",
      "translationEn": "Glory be to Allah (SWT).",
      "translationBn": "",
    },
    {
      "id": "3",
      "dhikir": "Astaghfirullah",
      "arabic": "استغفرالله",
      "translationEn": "I seek forgiveness from Allah (SWT).",
      "translationBn": "",
    },
    {
      "id": "4",
      "dhikir": "Allahu Akbar",
      "arabic": "الله أكبر",
      "translationEn": "Allah (SWT) is the greatest.",
      "translationBn": "",
    },
    {
      "id": "5",
      "dhikir": "La Ilaha Illallah",
      "arabic": "لا إلها اللله",
      "translationEn": "There is none worthy of worship except Allah (SWT).",
      "translationBn": "",
    },
    {
      "id": "6",
      "dhikir": "La Hawla Wala Quwwata Illa Billah",
      "arabic": "لا حول ولا قوات إلى بالله",
      "translationEn": "There is neither might nor power but with Allah (SWT).",
      "translationBn": "",
    },
  ];

  List<Dhikr> getAllDhikrs() {
    final stored = LocalStorageService.get<List>(AppConstants.dhikirListKey);
    
    if (stored == null) {
      _initializeDefaultDhikrs();
      return _defaultDhikrs.map((json) => Dhikr.fromJson(json)).toList();
    }

    return (stored as List)
        .map((item) => Dhikr.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> addDhikr(Dhikr dhikr) async {
    final dhikrs = getAllDhikrs();
    dhikrs.add(dhikr);
    await _saveDhikrs(dhikrs);
  }

  Future<void> updateDhikr(int index, Dhikr dhikr) async {
    final dhikrs = getAllDhikrs();
    if (index >= 0 && index < dhikrs.length) {
      dhikrs[index] = dhikr;
      await _saveDhikrs(dhikrs);
    }
  }

  Future<void> deleteDhikr(int index) async {
    final dhikrs = getAllDhikrs();
    if (index >= 0 && index < dhikrs.length) {
      dhikrs.removeAt(index);
      await _saveDhikrs(dhikrs);
    }
  }

  Future<void> _saveDhikrs(List<Dhikr> dhikrs) async {
    final jsonList = dhikrs.map((d) => d.toJson()).toList();
    await LocalStorageService.put(AppConstants.dhikirListKey, jsonList);
  }

  void _initializeDefaultDhikrs() {
    LocalStorageService.put(AppConstants.dhikirListKey, _defaultDhikrs);
  }
}
