import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/tasksList/data/Task.dart';

class StatelessCard extends StatelessWidget {
  StatelessCard({Key? key, required this.task, required this.toggleBackground, required this.opened});
  final ToggleCallback toggleBackground;
  final Task task;
  final bool opened;

  @override
  Widget build(BuildContext context) {
    if(opened){
      return InkWell(
          onTap: () {
            toggleBackground(!opened);
          },
          child: Container(
            height: 250,
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
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40), // Image border
                  child: SizedBox.fromSize(
                    child:Image.network(task.image,
                        fit: BoxFit.fitWidth,
                        height: 250,
                        width: 375,
                    ),
                  ),
                ),
                _buildText(TextType.Description),
                _buildText(TextType.Location),
                _buildText(TextType.Date),
              ],
            )
          )
      );
    } else {
      return InkWell(
          onTap: () {
            toggleBackground(!opened);
          },
          child: Container(
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
                child:Image.network(task.image,
                    fit: BoxFit.fitWidth,
                    height: double.infinity,
                    width: double.infinity
                ),
              ),
            ),
          )
      );
    }

  }

  Container _buildText(TextType type){
    var desc = const Icon(Icons.description_outlined, size: 26, color: Color.fromRGBO(49, 49, 49, 1.0));
    var loc = const Icon(Icons.location_on_outlined, size: 29, color: Color.fromRGBO(49, 49, 49, 1.0));
    var date = const Icon(Icons.date_range_rounded, size: 26, color: Color.fromRGBO(49, 49, 49, 1.0));
    var icon;
    String text = "";
    String text2 = "";

    switch (type){
      case TextType.Description:
        text = "Description: ";
        text2 =  task.description;
        icon = desc;
        break;
      case TextType.Location:
        text = "Location: ";
        text2 =  task.location;
        icon = loc;
        break;
      case TextType.Date:
        text = "Date: ";
        text2 =  task.date;
        icon = date;
    }

    return Container(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const Padding(padding: EdgeInsets.only(left: 10)),
          Expanded(
              child: RichText(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                text: TextSpan(children: [
                  TextSpan(
                      text: text,
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(49, 49, 49, 1.0)
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: " " + text2,
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: const Color.fromRGBO(49, 49, 49, 1.0)
                            )
                        ),
                      ]
                  ),
                ]),
              ),
          )
        ],
      )
    );
  }

  Task getTask(){
    return task;
  }
}

enum TextType {
  Description,
  Location,
  Date
}

typedef ToggleCallback = dynamic Function(dynamic);