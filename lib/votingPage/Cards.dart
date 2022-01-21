import 'package:flutter/cupertino.dart';

class ExampleCard extends StatelessWidget {
  final String image;

  const ExampleCard({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: CupertinoColors.white,
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      alignment: Alignment.center,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(40), // Image border
          child: SizedBox.fromSize(
              child:Image.asset(image,
                  fit: BoxFit.fitHeight,
                  height: double.infinity,
                  width: double.infinity
              ),
          ),
      ),
    );
  }
}