import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/tasksList/arrow_clipper.dart';

import 'TaskList.dart';

class SimpleAccountMenu extends StatefulWidget {
  final List icons;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final ValueChanged<int> onChange;

  const SimpleAccountMenu({
    required Key key,
    required this.icons,
    required this.borderRadius,
    this.backgroundColor = Colors.white,
    required this.onChange,
  })  : super(key: key);
  @override
  _SimpleAccountMenuState createState() => _SimpleAccountMenuState();
}

class _SimpleAccountMenuState extends State<SimpleAccountMenu>
    with SingleTickerProviderStateMixin {
  late GlobalKey _key;
  bool isMenuOpen = false;
  late Offset buttonPosition;
  late Size buttonSize;
  late OverlayEntry _overlayEntry;
  late BorderRadius _borderRadius;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _borderRadius = widget.borderRadius;
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  @override
  void dispose() {
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
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: _borderRadius,
      ),
      child: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationController,
        ),
        color: Colors.white,
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
          width: 200,
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
                      color: widget.backgroundColor,
                      borderRadius: _borderRadius,
                    ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(widget.icons.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              widget.onChange(index);
                              //closeMenu();
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