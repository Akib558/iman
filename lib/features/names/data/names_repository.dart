import 'package:prayer_app/features/names/domain/allah_name.dart';
import 'package:prayer_app/importanFiles/nameOfAllah.dart';

class NamesRepository {
  List<AllahName> getAllNames() {
    return nameOfAllah
        .map((json) => AllahName.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  AllahName? getNameById(int id) {
    try {
      final json = nameOfAllah.firstWhere(
        (item) => (item as Map<String, dynamic>)['id'] == id,
      );
      return AllahName.fromJson(json as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  int get totalCount => nameOfAllah.length;
}
