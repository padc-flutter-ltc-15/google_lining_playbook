import 'package:flutter/material.dart';
import 'package:google_play_book/custom_components/smart_list_view.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/rating_overview_with_progress_bar_indicator.dart';
import 'package:google_play_book/widgets/rating_view_by_users.dart';
import 'package:google_play_book/widgets/text_view.dart';

class RatingDetailsPage extends StatelessWidget {
  const RatingDetailsPage({Key? key}) : super(key: key);

  final List<String> ratingChips = const ["5", "4", "3", "2", "1"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitleView(),
        leading: const AppBarLeadingVIew(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const RatingOverViewWithProgressBarIndicator(),
            SizedBox(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.only(left: 9.0),
                child: SmartHorizontalListView(
                    itemCount: ratingChips.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: FilterChip(
                          selectedColor: LIGHT_THEME_TERTIARY_COLOR,
                          side: const BorderSide(
                              color: GREY_COLOR, width: 0.5),
                          backgroundColor: WHITE_COLOR,
                          labelPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 1),
                          label: Row(
                            children: [
                              TextView(
                                text: ratingChips[index],
                                fontColor: Colors.black54,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const IconView(
                                  icon: Icons.star,
                                  iconColor: Colors.black54,
                                  iconSize: 20),
                            ],
                          ),
                          onSelected: (isSelected) {}),
                    ),
                    onListEndReached: () {},
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                userImage: "images/avatar1.jpg",
                userName: "Coldplay",
                userComment:
                "Something just like this",
                reviewDate: "May, 2023",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                userName: "John Wick",
                userComment:
                "Yea...",
                reviewDate: "May, 2023",
                userImage: "images/avatar2.jpg",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                userImage: "images/avatar3.jpg",
                userName: "Fredrick Nietsche",
                userComment:
                "Amor Fati",
                reviewDate: "May, 2023",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                userImage: "images/avatar3.jpg",
                userName: "Platos",
                userComment:
                "Pythagorem Theorem",
                reviewDate: "May, 2023",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                userImage: "images/avatar3.jpg",
                userName: "Usher",
                userComment:
                "Yeah man!",
                reviewDate: "May, 2023",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                userImage: "images/avatar3.jpg",
                userName: "Rocket",
                userComment:
                "Flying!",
                reviewDate: "May, 2023",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                userImage: "images/avatar3.jpg",
                userName: "Zuckerburg",
                userComment:
                "LGTM!",
                reviewDate: "May, 2023",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                userImage: "images/avatar3.jpg",
                userName: "Sarah Silverman",
                userComment:
                "Good",
                reviewDate: "May, 2023",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                userImage: "images/avatar3.jpg",
                userName: "Wayne",
                userComment:
                "Clark!",
                reviewDate: "May, 2023",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarLeadingVIew extends StatelessWidget {
  const AppBarLeadingVIew({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconView(
        icon: Icons.keyboard_arrow_left, iconColor: Colors.black87, iconSize: 30);
  }
}

class AppBarTitleView extends StatelessWidget {
  const AppBarTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextView(
      text: "Ratings and reviews",
      fontColor: Colors.black87,
      fontSize: 20,
    );
  }
}
