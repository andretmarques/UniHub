import 'package:flutter/material.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/constants/Constants.dart' as constants;



class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var halfLogoUtils = HalfLogoUtils();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
            children: [
              Row(
                  children: [
                    buildButtonContainer("WALLET"),
                    const Padding(padding: EdgeInsets.only(right: 15.0)),
                    buildButtonContainer("SHOPPING")
                  ],
                  mainAxisAlignment: MainAxisAlignment.center
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15.0)),
              Row(
                  children: [
                    buildButtonContainer("STATISTICS"),
                    const Padding(padding: EdgeInsets.only(right: 15.0)),
                    buildButtonContainer("TASKS")
                  ],
                  mainAxisAlignment: MainAxisAlignment.center
              ),
              const Padding(padding: EdgeInsets.only(bottom: 30.0))
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
    );
  }

  Widget buildButtonContainer(String type) {
    var wallet = const Icon(Icons.account_balance_wallet_outlined, size: 60, color: constants.LOGO_GREY,);
    var shopping = const Icon(Icons.shopping_basket_outlined, size: 60, color: constants.LOGO_GREY,);
    var statistics = const Icon(Icons.leaderboard_outlined, size: 60, color: constants.LOGO_GREY,);
    var tasks = const Icon(Icons.sticky_note_2_outlined, size: 60, color: constants.LOGO_GREY,);

    var icon;

    switch (type) {
      case "WALLET":
        icon = wallet;
        break;
      case "SHOPPING":
        icon = shopping;
        break;
      case "STATISTICS":
        icon = statistics;
        break;
      case "TASKS":
        icon = tasks;
        break;
    }

    return Center(
        child: InkWell(
          onTap: () {},
          child: Ink(
              height: 165,
              width: 165,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(170, 170, 170, 1)
                ),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    icon,
                    Text(type)
                  ]
              )
          ),
        )
    );
  }
}