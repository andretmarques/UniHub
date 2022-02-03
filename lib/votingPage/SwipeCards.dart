import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:tcard/tcard.dart';


import 'package:flutter/material.dart';
import 'package:unihub/tasksList/data/Task.dart';
import 'package:unihub/tasksList/data/TasksDao.dart';
import 'package:unihub/constants/Constants.dart' as Constants;

import 'CardsStateless.dart';


class SwipeCards extends StatefulWidget {
  SwipeCards({Key? key, required this.toggleBackground, required this.evaluateTask, required this.startingTask}) : super(key: key);
  final ToggleCallback toggleBackground;
  final VoidCallback evaluateTask;
  final int startingTask;


  final taskDao = TaskDao();

  @override
  State<SwipeCards> createState() => _SwipeCardsState(toggleBackground: toggleBackground, evaluateTask: evaluateTask, startingTask: startingTask);
}

class _SwipeCardsState extends State<SwipeCards> {
  _SwipeCardsState ({Key? key, required this.toggleBackground, required this.evaluateTask, required this.startingTask});
  TCardController controller = TCardController();
  final ToggleCallback toggleBackground;
  final VoidCallback evaluateTask;
  bool opened = false;
  int currentIndex = 0;
  final int startingTask;
  double heightMul = 0.52;
  bool show = true;
  List<Task> tasksToEvaluate = [];

  late List<StatelessCard> cards;
  @override
  void initState() {
    show = startingTask < 5;
    cards = [StatelessCard(task: Task("", "", "https://media.istockphoto.com/vectors/loading-icon-vector-id695717992?k=20&m=695717992&s=170667a&w=0&h=-CJPOSDqhQK4i5D0ZPYf4DiSwF3OBhWiWtH8R7NBsm4=", "", "", "", "", 0), toggleBackground: toggleBack, opened: false,)];
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
          if (show) ...[
            SizedBox(
              height: MediaQuery.of(context).size.height * heightMul,
              child: TCard(
                cards: cards,
                size: const Size(375, 425),
                controller: controller,
                onForward: (index, info) {
                  onSwipe(info, index);
                },
                onEnd: () {
                  //Todo on end logic
                  log('end');
                },
              ),
            ),
          ] else ... [
            SizedBox(
              height: MediaQuery.of(context).size.height * heightMul,
            ),
          ],
          Row(
              children: [
                if(!opened) ...[
                  _buildLogos("CROSS", controller),
                  _buildLogos("LOVE", controller)
                ]
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround)
              ]
      ),
    );
  }

  Widget _buildLogos(String type, TCardController controller) {
    var love = const Icon(Icons.favorite_border_rounded, size: 50, color: Constants.PINK_BUTTON);
    var cross = const Icon(Icons.close, size: 50, color: Constants.PINK_BUTTON);
    var icon;
    var pressed;

    switch (type) {
      case "LOVE":
        icon = love;
        pressed = SwipDirection.Right;
        break;
      case "CROSS":
        icon = cross;
        pressed = SwipDirection.Left;
        break;
    }
    return Center(
        child: Container(
            height: 95,
            alignment: Alignment.center,
            child: SizedBox(
                    height: 95,
                    width: 95,
                    child: IconButton(
                        icon: icon,
                        onPressed: () { controller.forward(direction: pressed);}
                    )
                ),
        )
    );
  }

  void _loadCards() {
    if(startingTask < 5){
      Query query = widget.taskDao.getFiveTaskQuery();
      query.get().then((value) {
        if(value.value != null){
          var tasks = value.value as List<dynamic>;
          tasks = tasks.skip(startingTask).toList();
          cards.clear();
          for (var taskv in tasks) {
            var json = taskv as Map<dynamic, dynamic>;
            var task = Task.fromJson(json);
            tasksToEvaluate.add(task);
            cards.add(StatelessCard(task: task, toggleBackground: toggleBack, opened: false));
          }
          setState(() {
            controller.reset(cards: cards);
          });
        }
      });
    }
  }

  void onSwipe(SwipInfo info, int index){
    if(info.direction == SwipDirection.Right){
      FirebaseDatabase.instance.ref().child('tasks').child(currentIndex.toString()).update({
        "upvotes": tasksToEvaluate[currentIndex].upvotes+1,
      });
    }
    setState(() {
      currentIndex = index;
    });
    evaluateTask();
  }

  void changeCardState(){

    for(int i = currentIndex; i < cards.length; i++){
      cards[i] = StatelessCard(task: cards[i].getTask(), toggleBackground: toggleBack, opened: !cards[i].opened);
    }
    cards = cards.skip(currentIndex).toList();
    currentIndex = 0;
    controller.reset(cards: cards);
  }

  dynamic toggleBack(dynamic){
    toggleBackground(dynamic);
    changeCardState();
    setState(() {
      heightMul = opened ? 0.52 : 0.68;
      opened = !opened;
    });
  }

}

typedef ToggleCallback = dynamic Function(dynamic);