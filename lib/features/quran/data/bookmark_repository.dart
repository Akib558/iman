import 'package:hive/hive.dart';
import '../domain/ayah_bookmark.dart';

class BookmarkRepository {
  static const String _boxName = 'ayah_bookmarks';
  
  Box<dynamic>? _box;

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  Box<dynamic> get _openBox {
    if (_box == null || !_box!.isOpen) {
      throw Exception('Bookmark box not initialized');
    }
    return _box!;
  }

  Future<void> addBookmark(AyahBookmark bookmark) async {
    final box = _openBox;
    await box.put(bookmark.bookmarkId, bookmark.toJson());
  }

  Future<void> removeBookmark(String bookmarkId) async {
    final box = _openBox;
    await box.delete(bookmarkId);
  }

  Future<void> updateBookmark(AyahBookmark bookmark) async {
    await addBookmark(bookmark);
  }

  List<AyahBookmark> getAllBookmarks() {
    final box = _openBox;
    final List<AyahBookmark> bookmarks = [];

    for (var key in box.keys) {
      try {
        final json = box.get(key) as Map<dynamic, dynamic>;
        final bookmark = AyahBookmark.fromJson(Map<String, dynamic>.from(json));
        bookmarks.add(bookmark);
      } catch (e) {
        // Skip invalid entries
      }
    }

    // Sort by creation date (newest first)
    bookmarks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return bookmarks;
  }

  List<AyahBookmark> getBookmarksByCategory(String? category) {
    final all = getAllBookmarks();
    if (category == null) {
      return all.where((b) => b.category == null).toList();
    }
    return all.where((b) => b.category == category).toList();
  }

  bool isBookmarked(int surahNumber, int ayahNumber) {
    final box = _openBox;
    final bookmarkId = '$surahNumber-$ayahNumber';
    return box.containsKey(bookmarkId);
  }

  AyahBookmark? getBookmark(int surahNumber, int ayahNumber) {
    final box = _openBox;
    final bookmarkId = '$surahNumber-$ayahNumber';
    
    if (!box.containsKey(bookmarkId)) return null;
    
    try {
      final json = box.get(bookmarkId) as Map<dynamic, dynamic>;
      return AyahBookmark.fromJson(Map<String, dynamic>.from(json));
    } catch (e) {
      return null;
    }
  }

  List<String> getAllCategories() {
    final bookmarks = getAllBookmarks();
    final categories = bookmarks
        .where((b) => b.category != null)
        .map((b) => b.category!)
        .toSet()
        .toList();
    categories.sort();
    return categories;
  }

  Future<void> deleteAllBookmarks() async {
    final box = _openBox;
    await box.clear();
  }
}
