import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/votingPage/SwipeCards.dart';



class VotingPage extends StatefulWidget {
  VotingPage({Key? key,  required this.toggleBackground, required this.evaluateTask, required this.tasksEvaluated}) : super(key: key);
  final ToggleCallback toggleBackground;
  final VoidCallback evaluateTask;
  int tasksEvaluated;

  @override
  State<StatefulWidget> createState() => _VotingPageState(toggleBackground: toggleBackground, evaluateTask: evaluateTask, tasksEvaluated: tasksEvaluated);
}

class _VotingPageState extends State<VotingPage> {
  _VotingPageState ({Key? key, required this.toggleBackground, required this.evaluateTask, required this.tasksEvaluated});
  var halfLogoUtils = HalfLogoUtils();
  final ToggleCallback toggleBackground;
  final VoidCallback evaluateTask;
  int tasksEvaluated;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 100.0)),
            Container(
              width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(170, 170, 170, 1.0)
                ),
                borderRadius: BorderRadius.circular(90),
                color: Colors.white,
              ),
              child: Text( tasksEvaluated.toString() + "/5",
                  style: GoogleFonts.roboto(
                      color: const Color.fromRGBO(170, 170, 170, 1.0), fontWeight: FontWeight.w300, fontSize: 16)
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            buildTextLabel("Please evaluate 5 tasks"),
            SwipeCards(toggleBackground: toggleBackground, evaluateTask: myEvaluateTask, startingTask: tasksEvaluated,)
          ])
    );
  }

  Widget buildTextLabel(String text) {
    return Text(text,
        style: GoogleFonts.roboto(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14)
    );
  }

  void myEvaluateTask(){
    evaluateTask();
    setState(() {
      tasksEvaluated++;
    });
  }

}

typedef ToggleCallback = dynamic Function(dynamic);