import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/widgets/text_view.dart';
import '../resources/colors.dart';

class DefaultAppBarView extends StatelessWidget {
  const DefaultAppBarView({Key? key, required this.onTapSearch})
      : super(key: key);

  final Function onTapSearch;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapSearch(),
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 10),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(8),
              color: WHITE_COLOR),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextView(
                      text: "Search Play Books",
                      fontColor: Colors.black54,
                      fontSize: 16, fontWeight: FontWeight.w500,
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.all(2),
                      clipBehavior: Clip.antiAlias,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.blue, Colors.green, Colors.yellow],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "images/avatar1.jpg",
                          height: 32,
                          width: 32,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
