import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/utils/Utils.dart';
import 'package:unihub/constants/Constants.dart' as Constants;

class IdentityPage extends StatefulWidget {
  const IdentityPage({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<IdentityPage> createState() => _IdentityPageState();
}

class Tech
{
  String label;
  Color color;
  Tech(this.label, this.color);
}

class _IdentityPageState extends State<IdentityPage> {
  _IdentityPageState ({Key? key });
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  static const utils = Utils();

  int selectedIndex = 0;
  final List<Tech> _chipsList = [
    Tech("Teacher", Colors.green),
    Tech("Student", Colors.blueGrey)
    ];


  @override
  Widget build(BuildContext context) {
    var chips = _buildIsTeacherForm();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Constants.HALF_LOGO, scale: 1.5),
              _buildBlueTextLabel('IDENTIFY YOURSELF'),
              const Padding(padding: EdgeInsets.only(bottom: 20.0)),
              FormBuilder(
                  key: formKey,
                  child: Column(
                      children: [
                        Container(child: Image.asset(
                            'assets/images/cctemplate.png', scale: 3),
                            margin: EdgeInsets.all(25.0)),
                        utils.buildInput(FormInputType.CC),
                        const Padding(padding: EdgeInsets.only(bottom: 40.0)),
                        Container(child: Text('Choose your role', style: GoogleFonts.roboto(
                            color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16)),
                            alignment: Alignment.center),
                        const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                        Wrap(spacing: 6,
                              direction: Axis.horizontal,
                              children: chips.chips),
                        const Padding(padding: EdgeInsets.only(bottom: 50.0)),
                        utils.buildButton("CREATE", formKey, context, chips.isTeacher),
                      ])
              ),
            ]),
      ),
    );
  }

  Text _buildBlueTextLabel(String text) {
    return Text(text,
        style: GoogleFonts.roboto(
            color: Constants.PRIMARY_COLOR,
            fontWeight: FontWeight.w700,
            fontSize: 26));
  }


  FormatResult _buildIsTeacherForm () {
    List<Widget> chips = [];
    for (int i=0; i< _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left:10, right: 5),
        child: ChoiceChip(
          label: Text(_chipsList[i].label, style: GoogleFonts.roboto(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 27)),
          selected: selectedIndex == i,
          onSelected: (bool value)
          {
            setState(() {
              selectedIndex = i;
            });
          },
          shadowColor: Colors.grey,
          selectedShadowColor: Colors.amberAccent,
          selectedColor: Constants.PRIMARY_COLOR,
          elevation: 3,
          backgroundColor: Colors.black38,
        ),
      );
      chips.add(item);
    }
    return FormatResult(chips, selectedIndex == 0);
  }
}

class FormatResult {
  List<Widget> chips;
  bool isTeacher;
  FormatResult(this.chips, this.isTeacher);
}

