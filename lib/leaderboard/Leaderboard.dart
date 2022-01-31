import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../userData/User.dart';
import '../userData/UsersDao.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:unihub/constants/Constants.dart' as Constants;

class LeaderboardState extends State<LeaderboardList> {
  final ScrollController _scrollController = ScrollController();

  bool top3 = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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
        sort: (a, b) {
            var ai = a.child("tasksDone").value as int;
            var bi = b.child("tasksDone").value as int;
            return bi - ai;
        },
        reverse: false,
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final user = User.fromJson(json);
          if(top3){
            if(index < 3){
              return top3Container(user.name, user.image, user.tasks, index.toDouble());
            }
          } else {
            return normalContainer(user.name, user.image, user.tasks, index);
          }
          return Container();
        },
      ),
    );
  }

  Container top3Container(name, image, tasks,double index){
    return Container(
        margin: const EdgeInsets.only(bottom: 38),
        height: 140,
        child: MaterialButton(
          padding: const EdgeInsets.only(),
          onPressed: () {
            setState(() {
              top3 = !top3;
            });
          },
          child: Stack(
            children: [
              Container(
                  margin: EdgeInsets.only(top:20 + index*5/1.25, left: 30 + index*3, right: index*25),
                  height: 90 - index*5,
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
                  child: Center(
                    child: Text(
                        "   " + tasks.toString() + " Tasks Done",
                        style: GoogleFonts.roboto(
                            fontSize: 28 - index*3,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(90, 90, 90, 1)
                        )
                    ),
                  )
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 52 - index*2, // Image radius
                    backgroundImage: NetworkImage(image),
                  ),
                  Text(name,
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }


  Container normalContainer(name, image, tasks, index){
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
                Text((index + 1).toString(),
                    style: GoogleFonts.roboto(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Constants.MAIN_YELLOW
                    )
                ),
                const SizedBox(width: 10,),
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