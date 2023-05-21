
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_play_book/blocs/more_audio_books_bloc.dart';
import 'package:google_play_book/data/data_vos/books_vo.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';
import 'package:provider/provider.dart';

import '../data/data_vos/more_list_results_vo.dart';
import 'book_details_page.dart';
import 'home_page.dart';

class MoreAudiobooksPage extends StatefulWidget {

  final String listName;

  const MoreAudiobooksPage({
    Key? key,
    required this.listName
  }): super(key: key);

  @override
  State<MoreAudiobooksPage> createState() => _MoreAudiobooksPageState();
}

class _MoreAudiobooksPageState extends State<MoreAudiobooksPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MoreAudioBooksBloc(widget.listName),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const IconView(
                icon: Icons.keyboard_arrow_left,
                iconColor: Colors.black,
                iconSize: 30),
          ),
          title: TextView(
            text: "More Audiobooks",
            fontSize: 18,
          ),
        ),
        body: Selector<MoreAudioBooksBloc, List<MoreListResultsVO>?>(
          selector: (context, bloc) => bloc.listsResults,
          builder: (context, listsResult, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: (listsResult != null)? GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: listsResult.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 240, crossAxisSpacing: 15),
              itemBuilder: (context, index) => MoreAudiobookItemView(
                onTapAudiobook: () => navigateToBookDetailsPage(context, listsResult[index].bookDetails?.first!),
                book: listsResult[index],
              ),
            ): Center(
              child: CircularProgressIndicator(
                color: LIGHT_THEME_SELECTED_CHIP_COLOR,
              ),
            ),
          ),
        )
      ),
    );
  }
}

class MoreAudiobookItemView extends StatelessWidget {
  // bookList?.books?[index].bookImage ?? ""
  const MoreAudiobookItemView({
    Key? key,
    required this.onTapAudiobook,
    required this.book,
  })
      : super(key: key);
  final Function onTapAudiobook;
  final MoreListResultsVO? book;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapAudiobook(),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                width: 180,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.network(
                  "https://storage.googleapis.com/du-prd/books/images/${book?.isbns?.first.isbn13}.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 7,
                top: 5,
                child: InkWell(
                  onTap: () => {

                  },
                  child: const IconView(
                      icon: Icons.more_horiz_outlined,
                      iconColor: GREY_COLOR,
                      iconSize: 25),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: APP_PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const IconView(
                      icon: Icons.headphones_outlined,
                      iconColor: WHITE_COLOR,
                      iconSize: 20),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 40,
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: book?.bookDetails?.first.title ?? "",
                  fontSize: 15,
                  fontColor: Colors.black87,
                  maxLines: 1,
                ),
                TextView(
                  text: book?.bookDetails?.first.author ?? "",
                  fontColor: Colors.black54,
                  fontWeight: FontWeight.w400,
                  maxLines: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<dynamic> navigateToBookDetailsPage(BuildContext context, BooksVO? bookDetail) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => BookDetails(isAudiobook: true, bookDetails: bookDetail,bookLists: null,),
    ),
  );
}
