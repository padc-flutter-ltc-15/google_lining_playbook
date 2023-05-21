import 'package:flutter/cupertino.dart';

import '../data/data_vos/books_vo.dart';
import '../data/data_vos/shelf_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';

class YourBooksBloc extends ChangeNotifier {
  int viewTypeValue = 1;
  List<String> categoryChipLabels = [];
  List<bool> chipIsSelected = [];
  List<ShelfVO>? shelfList;

  GooglePlayBookModel model = GooglePlayBookModelImpl();
  List<BooksVO>? savedBookList;
  bool isShowClearButton = false;
  bool isDisposed = false;
  int count = 0;

  List<BooksVO>? temp;
  List<BooksVO> tempCombined = [];

  YourBooksBloc() {
    /// getAllShelves from DB
    getAllShelvesStream();

    /// getAllBooks from DB
    getSavedBookList();
  }

  Future<void> getAllShelvesStream() async{
    model.getAllShelvesStream().listen((event) {
      event.sort((a, b) => (a.shelfName ?? "").compareTo(b.shelfName ?? ""));
      shelfList = event.toList();
      checkNotifyListener();
    });
  }

  Future<void> getSavedBookList() async {
    model.getSaveBookListStream().listen((value) {
      value.sort((a, b) => (a.saveTime ?? 0).compareTo(b.saveTime ?? 0));
      savedBookList = value.reversed.toList();
      chipList();
      checkNotifyListener();
    });
  }

  void chipList() {
    if (savedBookList != null) {
      for (int i = 0; i < savedBookList!.length; i++) {
        if (!(categoryChipLabels.contains(savedBookList?[i].categoryName)) &&
            savedBookList?[i].categoryName != null) {
          categoryChipLabels.add(savedBookList?[i].categoryName ?? "");
          chipIsSelected.add(false);
          checkNotifyListener();
        }
      }
    }
  }

  void setViewTypeValue({required int val}) {
    viewTypeValue = val;
    checkNotifyListener();
  }

  void sortBookByType({required int val}) {
    setViewTypeValue(val: val);
    if (val == 1) {
      savedBookList?.sort((a, b) => (a.saveTime ?? 0).compareTo(b.saveTime ?? 0));
      checkNotifyListener();
    } else if (val == 2) {
      savedBookList?.sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
      checkNotifyListener();
    } else if (val == 3) {
      savedBookList?.sort((a, b) => (a.author ?? "").compareTo(b.author ?? ""));
      checkNotifyListener();
    }
  }

  void setSelectedChipIndex(
      {required int index, required bool isSelected}) async {
    chipIsSelected[index] = isSelected;
    await getBookByCategory(categoryChipLabels[index]);
    checkNotifyListener();
  }

  void showClearBtn({required bool value}) {
    isShowClearButton = value;
    checkNotifyListener();
  }

  void setToDefault() async {
    showClearBtn(value: false);
    chipIsSelected = chipIsSelected.map((e) => false).toList();
    tempCombined.clear();
    temp?.clear();
    await getSavedBookList();
    checkNotifyListener();
  }

  Future<void> getBookByCategory(String name) async {
    model.getSavedAllBooks().then((value) {
      temp = value.where((e) => e.categoryName == name).toList();
      tempCombined += temp ?? [];
      temp?.clear();
      savedBookList = tempCombined.toSet().toList();
      notifyListeners();
    });
  }

  void checkNotifyListener() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void clearDisposeNotify() {
    if (!isDisposed) {
      isDisposed = true;
    }
  }
}
