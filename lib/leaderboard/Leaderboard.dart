import 'dart:developer';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'data/User.dart';
import 'data/UsersDao.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class LeaderboardState extends State<LeaderboardList> {
  final ScrollController _scrollController = ScrollController();

  bool top3 = true;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 100)),
                _getMessageList()
            ]
        ),
      ),
    );
  }

  Widget _getMessageList() {
    return Expanded(
      child:
      FirebaseAnimatedList(
        controller: _scrollController,
        query: widget.userDao.getUserQuery(),
        reverse: true,
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final user = User.fromJson(json);
          if(top3){
            if(index < 3){
              return top3Container(user.name, user.image, user.tasks);
            }
          } else {
            return normalContainer(user.name, user.image, user.tasks);
          }
          return Container();
        },
      ),
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  Container top3Container(name, image, tasks){
    return Container(
        height: 120,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top:10, left: 30),
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(170, 170, 170, 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[350]!,
                        blurRadius: 2.0,
                        offset: const Offset(0, 1.0))
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
            ),
            MaterialButton(
                disabledTextColor: Colors.black87,
                padding: const EdgeInsets.only(left: 5),
                onPressed: () {
                  setState(() {
                    top3 = !top3;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 54, // Image radius
                      backgroundImage: NetworkImage(image),
                    ),
                    const SizedBox(width: 20,),
                    Column(
                      children: [
                        Text(name,
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            )
                        ),
                        Text(tasks.toString() + " Tasks Done",
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.black
                            )
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ],
                ))
          ],
        )
    );
  }


  Container normalContainer(name, image, tasks){
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 10),
        height: 90,
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(170, 170, 170, 1),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[350]!,
                  blurRadius: 2.0,
                  offset: const Offset(0, 1.0))
            ],
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white),
        child: MaterialButton(
            disabledTextColor: Colors.black87,
            padding: const EdgeInsets.only(left: 5),
            onPressed: () {
              setState(() {
                top3 = !top3;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40, // Image radius
                  backgroundImage: NetworkImage(image),
                ),
                const SizedBox(width: 20,),
                Column(
                  children: [
                    Text(name,
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(90, 90, 90, 1)
                        )
                    ),
                    Text(tasks.toString() + " Tasks Done",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromRGBO(90, 90, 90, 1)
                        )
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
            ))
    );
  }

}

class LeaderboardList extends StatefulWidget {
  LeaderboardList({Key? key}) : super(key: key);

  final userDao = UserDao();

  @override
  LeaderboardState createState() => LeaderboardState();
}