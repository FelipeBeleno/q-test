import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:technical_test/entities/book_entity.dart';
import 'package:technical_test/models/book_model.dart';

class BookProvider extends ChangeNotifier {
  final dio =
      Dio(BaseOptions(baseUrl: 'https://openlibrary.org/search.json?q='));

  final String coverIImagePath =
      'https://covers.openlibrary.org/b/id/[cover_i]-L.jpg';
  final String authorKeyImagePath =
      'https://covers.openlibrary.org/a/olid/[author_key]-L.jpg';

  List<BookEntity> _books = [];
  bool loader = false;
  BookEntity bookSelected = BookEntity(
      authorName: '',
      coverIImage: '',
      firstPublishYear: 0,
      key: '',
      keyAuhorImage: '',
      title: '',
      firstSentence: '');

  List<BookEntity> get books => _books;

  Future<void> setBooks(String text) async {
    changeLoader(true);
    _books = [];

    final response = await dio.get(
        '$text&fields=key,title,author_name,author_key,first_publish_year,cover_i,first_sentence');

    final books = BoocksModel.fromJson(response.data);
    if (books.docs.isEmpty) {
      changeLoader(false);
      notifyListeners();
      return;
    }
    for (var e in books.docs) {
      final newBook = BookEntity(
          key: e.key,
          title: e.title,
          authorName: e.authorName.isEmpty ? "No registra" : e.authorName[0],
          keyAuhorImage: e.authorKey.isEmpty
              ? "No registra"
              : authorKeyImagePath.replaceFirst('[author_key]', e.authorKey[0]),
          coverIImage: e.coverI == 0
              ? 'assets/no-image.jpg'
              : coverIImagePath.replaceFirst('[cover_i]', e.coverI.toString()),
          firstPublishYear: e.firstPublishYear,
          firstSentence: e.firstSentence);

      _books.add(newBook);
    }

    notifyListeners();
    changeLoader(false);
  }

  Future<void> getBookByIdSelected(String id) async {
    bookSelected =
        _books.firstWhere((b) => b.key.replaceFirst('/works/', '') == id);
  }

  changeLoader(bool status) {
    loader = status;
    notifyListeners();
  }
}
