library bottom_navy_bar;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// @ts-ignore
class BottomNavyBar extends StatefulWidget {
  int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;

  BottomNavyBar({
    Key key,
    this.selectedIndex = 0,
    this.iconSize = 24,
    this.backgroundColor,
    @required this.items,
    @required this.onItemSelected,
  }) {
    assert(items != null);
    assert(items.length >= 2 || items.length >= 5);
    assert(onItemSelected != null);
  }

  @override
  _BottomNavyBarState createState() => _BottomNavyBarState(
        items: items,
        backgroundColor: backgroundColor,
        iconSize: iconSize,
        onItemSelected: onItemSelected,
      );
}

class _BottomNavyBarState extends State<BottomNavyBar> {
  final double iconSize;
  Color backgroundColor;
  List<BottomNavyBarItem> items;

  ValueChanged<int> onItemSelected;

  @override
  void initState() {
    super.initState();
  }

  _BottomNavyBarState({
    @required this.items,
    this.backgroundColor,
    this.iconSize,
    @required this.onItemSelected,
  });

  Widget _buildItem(BottomNavyBarItem item, bool isSelected) {
    return AnimatedContainer(
      width: isSelected ? 130 : 60,
      height: double.maxFinite,
      duration: Duration(milliseconds: 270),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? item.backgroundColor : backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: isSelected
                        ? item.activeColor.withOpacity(1)
                        : item.inactiveColor == null
                            ? item.activeColor
                            : item.inactiveColor,
                  ),
                  child: isSelected ? item.activeIcon ?? item.icon : item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                      style: TextStyle(
                          color: item.activeColor, fontWeight: FontWeight.bold),
                      child: item.title,
                    )
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 64,
      constraints: BoxConstraints(
        maxWidth: 600,
      ),
      padding: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
      decoration: BoxDecoration(color: backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              onItemSelected(index);
              setState(() {
                widget.selectedIndex = index;
              });
            },
            child: _buildItem(item, widget.selectedIndex == index),
          );
        }).toList(),
      ),
    );
  }
}

class BottomNavyBarItem {
  final Icon icon;
  final Text title;
  final Icon activeIcon;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;

  BottomNavyBarItem(
      {@required this.icon,
      @required this.title,
      this.activeIcon,
      this.activeColor = Colors.blue,
      this.inactiveColor,
      this.backgroundColor}) {
    assert(icon != null);
    assert(title != null);
  }
}
