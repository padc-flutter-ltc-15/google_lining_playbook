import 'package:flutter/foundation.dart';

import '../data/data_vos/books_vo.dart';
import '../data/data_vos/more_list_results_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';
import '../network/api_constants.dart';

class MoreAudioBooksBloc extends ChangeNotifier {

  /// Model
  GooglePlayBookModel model = GooglePlayBookModelImpl();

  /// State Variables
  List<MoreListResultsVO>? listsResults;
  BooksVO? bookDetails;

  MoreAudioBooksBloc(String listName){
    model.getMoreList(API_KEY, listName, "0-20").then((response) {
      response.results?.forEach((element) {
        element.bookDetails?.first.bookImage = "https://storage.googleapis.com/du-prd/books/images/${element.isbns?.first.isbn13}.jpg";
      });

      listsResults = response.results;
      notifyListeners();
    });
  }
}