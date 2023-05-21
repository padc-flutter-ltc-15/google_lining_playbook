import 'package:flutter/material.dart';
import 'package:google_play_book/blocs/more_ebooks_details_bloc.dart';
import 'package:google_play_book/data/models/google_play_book_model.dart';
import 'package:google_play_book/network/api_constants.dart';
import 'package:google_play_book/pages/book_view.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';
import 'package:provider/provider.dart';

import '../data/data_vos/books_vo.dart';
import '../data/data_vos/more_list_results_vo.dart';
import '../data/models/google_play_book_model_impl.dart';
import '../widgets/modal_bottom_sheet_for_menu.dart';
import 'book_details_page.dart';

class MoreEbooksPage extends StatefulWidget {
  const MoreEbooksPage({Key? key, required this.listName}) : super(key: key);

  final String listName;

  @override
  State<MoreEbooksPage> createState() => _MoreEbooksPageState();
}

class _MoreEbooksPageState extends State<MoreEbooksPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MoreEbooksDetailsBloc(widget.listName),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitleView(
            listName: widget.listName,
          ),
          leading: const AppBarLeadingView(),
        ),
        body: Selector<MoreEbooksDetailsBloc, List<MoreListResultsVO>?>(
          selector: (context, bloc) => bloc.listsResults,
          builder: (context, listsResults, child) => Padding(
            padding: const EdgeInsets.only(right: 15.0, left: 3),
            child: (listsResults != null)
                ? GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listsResults.length ?? 0,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.62),
                    itemBuilder: (context, index) => BookView(
                      imageHeight: 250,
                      imageWidth: 180,
                      titleWidth: 180,
                      rightMenuPadding: 5,
                      bottomDownloadPadding: 57,
                      rightDownloadPadding: 5,
                      onTapMenu: () =>
                          showBottomSheetForMenu(context, null, () {}),
                      bookCover: "https://storage.googleapis.com/du-prd/books/images/${listsResults[index].isbns?.first.isbn13}.jpg",
                      bookName:
                          listsResults[index].bookDetails?.first.title ?? "",
                      titleColor: Colors.black54,
                      authorColor: Colors.black45,
                      bookAuthorName:
                          listsResults[index].bookDetails?.first.author ?? "",
                      onTapBookView: () {
                        listsResults[index].bookDetails?.first.bookImage = "https://storage.googleapis.com/du-prd/books/images/${listsResults[index].isbns?.first.isbn13}.jpg";

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BookDetails(
                              bookDetails: listsResults[index].bookDetails?.first,
                              bookLists: null,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: LIGHT_THEME_SELECTED_CHIP_COLOR,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class AppBarLeadingView extends StatelessWidget {
  const AppBarLeadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconView(
        icon: Icons.keyboard_arrow_left,
        iconColor: APP_PRIMARY_COLOR,
        iconSize: 30);
  }
}

class AppBarTitleView extends StatelessWidget {
  const AppBarTitleView({Key? key, required this.listName}) : super(key: key);

  final String listName;

  @override
  Widget build(BuildContext context) {
    return TextView(
      text: listName,
      fontSize: 17,
      fontColor: APP_PRIMARY_COLOR,
    );
  }
}
