import 'package:flutter/cupertino.dart';

import 'package:unihub/custom_swiper/CustomSwiper.dart';
import 'package:flutter/material.dart';
import 'Cards.dart';
import 'package:unihub/constants/Constants.dart' as Constants;


class SwipeCards extends StatefulWidget {
  const SwipeCards({Key? key}) : super(key: key);

  @override
  State<SwipeCards> createState() => _SwipeCardsState();
}

class _SwipeCardsState extends State<SwipeCards> {
  final CustomSwiperController controller = CustomSwiperController();

  List<ExampleCard> images = [];
  List<String> text = [
    'assets/images/task2.jpg',
    'assets/images/task3.jpg',
    'assets/images/task4.jpg',
    'assets/images/task5.jpg',
    'assets/images/task1.jpg'
  ];

  @override
  void initState() {
    _loadCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.52,
            child: CustomSwiper(
              threshold: 100,
              controller: controller,
              cards: images,
              onSwipe: _swipe,
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 10,
                bottom: 10,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 25.0)),
          Row(
              children: [_buildLogos("CROSS", controller),
                _buildLogos("LOVE", controller)],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround)],
      ),
    );
  }

  Widget _buildLogos(String type, CustomSwiperController controller) {

    var love = const Icon(Icons.favorite_border_rounded, size: 50, color: Constants.PINK_BUTTON);

    var cross = const Icon(Icons.close, size: 50, color: Constants.PINK_BUTTON);

    var icon;

    var pressed;

    switch (type) {
      case "LOVE":
        icon = love;
        pressed = controller.swipeLeft;
        break;
      case "CROSS":
        icon = cross;
        pressed = controller.swipeRight;
        break;
    }
    return Center(
        child: Container(
            height: 95,
            alignment: Alignment.center,
            child: Container(
                height: 95,
                width: 95,
                child: IconButton(
                  icon: icon,
                  onPressed: () {pressed();}
                  )
            )
        )
    );
  }

  void _swipe(int index) {
    //print("swipe");
  }

  void _loadCards() {
    for (String text in text) {
      images.add(ExampleCard(image: text));
    }
  }
}