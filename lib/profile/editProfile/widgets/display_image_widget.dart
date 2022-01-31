import 'package:flutter/material.dart';
import 'package:unihub/constants/Constants.dart' as constants;

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = constants.MAIN_BLUE;

    return Stack(
        children: [
          buildImage(color),
          Positioned(
            child: buildEditIcon(color),
            right: 4,
            top: 10,
          )
        ]
    );
  }

  // Builds Profile Image
  Widget buildImage(Color color) {

    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: NetworkImage(imagePath),
        radius: 72,
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
    all: 8,
    child: const Icon(
      Icons.edit,
      color: Colors.white,
      size: 20,
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
            padding: EdgeInsets.all(all),
            color: constants.MAIN_BLUE,
            child: child,
          )
      );
}
