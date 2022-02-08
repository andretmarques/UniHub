import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/tasksList/arrow_clipper.dart';

import 'TaskList.dart';

class FilterDropDown extends StatefulWidget {
  final List icons;
  final Color backgroundColor;
  final ValueChanged<int> onChange;

  const FilterDropDown({
    Key? key,
    required this.icons,
    this.backgroundColor = Colors.white,
    required this.onChange,
  })  : super(key: key);
  @override
  _FilterDropDownState createState() => _FilterDropDownState();
}

class _FilterDropDownState extends State<FilterDropDown>
    with SingleTickerProviderStateMixin {
  late GlobalKey _key;
  bool isMenuOpen = false;
  late Offset buttonPosition;
  late Size buttonSize;
  late OverlayEntry _overlayEntry;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  @override
  void dispose() {
    if(isMenuOpen){
      closeMenu();
    }

    _animationController.dispose();
    super.dispose();
  }

  findButton() {
    RenderObject? renderBox = _key.currentContext?.findRenderObject();
    if (renderBox != null) {
      buttonSize = (renderBox as RenderBox).size;
      buttonPosition = renderBox.localToGlobal(Offset.zero);
    }
  }

  void closeMenu() {
    _overlayEntry.remove();
    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)?.insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      key: _key,
      width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
            border: Border.all(color: Colors.grey, width: 1.3),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0,
              offset: Offset(0, 4.0)),
        ]),

      child: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationController,
        ),
        color: Colors.black,
        onPressed: () {
          if (isMenuOpen) {
            closeMenu();
          } else {
            openMenu();
          }
        },
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: 150,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: ClipPath(
                    clipper: ArrowClipper(),
                    child: Container(
                      width: 17,
                      height: 17,
                      color: widget.backgroundColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: widget.icons.length * buttonSize.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.3),
                      color: widget.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(color: Colors.grey,
                          blurRadius: 4.0,
                          offset: Offset(0, 4.0))
                        ],
                    ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(widget.icons.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              widget.onChange(index);
                              closeMenu();
                            },
                            child: Row(children: [const Padding(padding: EdgeInsets.only(top: 50, left: 5)),
                              Text((widget.icons[index] as Item).name, style: GoogleFonts.roboto(fontSize: 19),),
                              const Padding(padding: EdgeInsets.only(right: 8)),
                              (widget.icons[index] as Item).icon,
                          ]),
                          );
                        }),
                      ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}