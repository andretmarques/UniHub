import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/constants/Constants.dart' as constants;
import 'package:unihub/faq/FaqConstants.dart' as faq;



class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  var halfLogoUtils = HalfLogoUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.arrow_back, size: 50, color: Colors.black,), onPressed: () {Navigator.pop(context);}),
                loadHalfLogo(),
                const SizedBox(width: 50.0),
              ],
            ),
            Text("FAQ Page",
                style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromRGBO(104, 102, 102, 1.0)
                )
            ),
            Expanded(child: buildFAQ()),
          ],
        )
    );
  }

  Widget buildFAQ() {
    faq.qa.forEach((k, v) {

    });
    return ListView.builder(
      itemBuilder: (context, index) {
        String key = faq.qa.keys.elementAt(index);

        return Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: constants.MAIN_BLUE,
              ),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Flexible(
                        child: Text(key,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: constants.MAIN_BLUE
                            )
                        )
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Row(
                  children: <Widget>[
                    Flexible(
                        child: Text(faq.qa[key],
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: constants.MAIN_BLUE
                            )
                        )
                    ),
                  ],
                )
              ],
            )
        );
      },
      itemCount: faq.qa.length,
    );
  }

  Container loadHalfLogo() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Image.asset(constants.HALF_LOGO, scale: 2)
    );
  }
}