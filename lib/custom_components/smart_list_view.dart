import 'dart:ffi';

import 'package:flutter/material.dart';

import '../data/data_vos/lists_vo.dart';

class SmartHorizontalListView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsets padding;
  final Function onListEndReached;
  final Axis scrollDirection;

  const SmartHorizontalListView(
      {Key? key,
      required this.itemCount,
      required this.itemBuilder,
      required this.onListEndReached,
      required this.padding,
      required this.scrollDirection})
      : super(key: key);

  @override
  State<SmartHorizontalListView> createState() =>
      _SmartHorizontalListViewState();
}

class _SmartHorizontalListViewState extends State<SmartHorizontalListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          debugPrint("Start of the List Reached");
        } else {
          debugPrint("End of the List Reached");
          widget.onListEndReached();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: widget.itemBuilder,
      itemCount: widget.itemCount,
      shrinkWrap: true,
      padding: widget.padding,
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      scrollDirection: widget.scrollDirection,
    );
  }
}
