
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../blocs/search_bloc.dart';
import '../data/data_vos/books_vo.dart';
import '../resources/colors.dart';
import '../widgets/default_app_bar_view.dart';
import '../widgets/icon_view.dart';
import '../widgets/text_view.dart';
import 'book_details_page.dart';
import 'home_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {

  late TabController _controller;
  final _searchController = TextEditingController();

  SearchBloc bloc = SearchBloc();

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);
  }

  void _searchBook(BuildContext context, String text) {
    bloc = Provider.of<SearchBloc>(context, listen: false);
    bloc.onUserSubmit();
    bloc.getGoogleSearch(text);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: AppBarView(
                  onTapClear: () => _searchController.clear(),
                  controller: _searchController,
                  onTapBack: () => Navigator.of(context).pop(),
                  onSubmitText: (text) {
                    _searchBook(context,text);
                  },
                ),
              ),
              body: NestedScrollView(
                headerSliverBuilder: (context, isScroll) {
                  return [
                    Selector<SearchBloc, List<BooksVO>?>(
                      shouldRebuild: (previous, next) => previous != next,
                      selector: (BuildContext context, bloc) => bloc.searchItems,
                      builder: (BuildContext context, saveBookList, Widget? child) {
                        return SliverAppBar(
                          automaticallyImplyLeading: false,
                          flexibleSpace: Column(
                            children: [
                              TabView(controller: _controller),
                            ],
                          ),
                        );
                      },
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _controller,
                  children: [
                    Selector<SearchBloc, List<BooksVO>?>(
                      selector: (context, bloc) => bloc.searchItems,
                      builder: (context, searchItems, child) => SearchedBookVerticalListView(
                        searchItems: searchItems,
                        isAudioBook: false,
                      ),
                    ),
                    Selector<SearchBloc, List<BooksVO>?>(
                      selector: (context, bloc) => bloc.searchItems,
                      builder: (context, searchItems, child) => SearchedBookVerticalListView(
                        searchItems: searchItems,
                        isAudioBook: true,
                      ),
                    ),
                  ],
                ),
              ),
            )
        );
      },
    );
  }
}

class SearchedBookVerticalListView extends StatelessWidget {

  final List<BooksVO>? searchItems;
  final bool isAudioBook;

  const SearchedBookVerticalListView({
    super.key, required this.searchItems, required this.isAudioBook,
  });

  @override
  Widget build(BuildContext context) {
    return (searchItems == null)?Container():ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: searchItems?.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BookDetails(
                  bookDetails: searchItems?[index],
                  bookLists: null),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20),
            child: SizedBox(
              height: 80,
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: 75,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.network(
                      searchItems?[index].bookImage ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView(
                          fontColor: Colors.black87,
                          fontSize: 15,
                          maxLines: 1,
                          text: searchItems?[index].title ?? "",
                        ),
                        TextView(
                          text: searchItems?[index].author ?? "",
                          maxLines: 2,
                          fontColor: Colors.black54,
                        ),
                        TextView(
                          text: (isAudioBook)?"Audio Book":"eBook",
                          fontColor: Colors.black54,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AppBarView extends StatefulWidget {
  const AppBarView(
      {Key? key,
        required this.controller,
        required this.onTapBack,
        required this.onSubmitText,
        required this.onTapClear})
      : super(key: key);

  final TextEditingController controller;
  final Function onTapBack;
  final Function onTapClear;
  final Function(String) onSubmitText;

  @override
  State<AppBarView> createState() => _AppBarViewState();
}

class _AppBarViewState extends State<AppBarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black54, width: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () => widget.onTapBack(),
            child: const IconView(
                icon: Icons.keyboard_arrow_left,
                iconColor: Colors.black54,
                iconSize: 33),
          ),
          SizedBox(
            width: 250,
            child: TextFormField(
              cursorHeight: 23, cursorWidth: 1.5,
              controller: widget.controller,
              cursorColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
              onFieldSubmitted: (text) {
                widget.onSubmitText(text);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                hintText: "Search Play Books",
                hintStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, color: Colors.black54),
                enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          InkWell(
            onTap: () => widget.onTapClear(),
            child: const IconView(
                icon: Icons.clear, iconColor: Colors.black54, iconSize: 25),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
