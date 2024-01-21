import 'dart:math';
import 'package:flutter/material.dart';

class NavigationMenu {
  final String label;
  final IconData icon;
  NavigationMenu({
    required this.label,
    required this.icon,
  });
}

enum QNavigationMode {
  nav0,
  nav1,
  nav2,
  nav3,
  docked,
}

class QNavigation extends StatefulWidget {
  final List<Widget> pages;
  final List<NavigationMenu> menus;
  final QNavigationMode mode;
  QNavigation({
    Key? key,
    required this.pages,
    required this.menus,
    this.mode = QNavigationMode.nav0,
  }) : super(key: key);
  @override
  State<QNavigation> createState() => _QNavigationState();
}

class _QNavigationState extends State<QNavigation> {
  int selectedIndex = 0;

  updateIndex(int newIndex) {
    selectedIndex = newIndex;
    setState(() {});
    print(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    double bottomBarHeight = 56;
    int pageCount = widget.pages.length;

    if (widget.mode == QNavigationMode.nav0)
      return DefaultTabController(
        length: widget.pages.length,
        initialIndex: selectedIndex,
        child: Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: widget.pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (newIndex) => updateIndex(newIndex),
            type: BottomNavigationBarType.fixed,
            items: List.generate(widget.menus.length, (index) {
              var item = widget.menus[index];
              return BottomNavigationBarItem(
                icon: Icon(
                  item.icon,
                ),
                label: item.label,
              );
            }),
          ),
        ),
      );
    if (widget.mode == QNavigationMode.nav1) {
      return DefaultTabController(
        length: widget.pages.length,
        initialIndex: selectedIndex,
        child: Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: widget.pages,
          ),
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsets.all(0.0),
            shape: CircularNotchedRectangle(),
            child: Container(
              height: bottomBarHeight,
              color: Colors.grey[900],
              child: Stack(
                children: [
                  Positioned(
                    left: 30,
                    right: 30,
                    top: 0,
                    bottom: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(widget.menus.length, (index) {
                        var item = widget.menus[index];
                        bool selected = index == selectedIndex;
                        if ((widget.menus.length / 2).floor() == index) {}
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 600),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Colors.white.withOpacity(selected ? 0.1 : 0.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          child: InkWell(
                            onTap: () => updateIndex(index),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  item.icon,
                                  size: 24.0,
                                  color: selected
                                      ? Colors.white
                                      : Colors.grey[700],
                                ),
                                if (selected)
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                if (selected)
                                  AnimatedScale(
                                    duration: Duration(milliseconds: 200),
                                    scale: selected ? 1.0 : 0.0,
                                    child: Text(
                                      item.label,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: selected
                                            ? Colors.white
                                            : Colors.grey[700],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (widget.mode == QNavigationMode.nav2) {
      return DefaultTabController(
        length: widget.pages.length,
        initialIndex: selectedIndex,
        child: Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: widget.pages,
          ),
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsets.all(0.0),
            shape: CircularNotchedRectangle(),
            child: Container(
              height: bottomBarHeight,
              child: Stack(
                children: [
                  if (1 == 2)
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: (MediaQuery.of(context).size.width / pageCount) *
                          selectedIndex,
                      bottom: 12,
                      child: Container(
                        width: MediaQuery.of(context).size.width / pageCount,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.circle,
                                size: 6.0,
                                color: Theme.of(context).primaryColor)
                          ],
                        ),
                      ),
                    ),
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 0,
                    bottom: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(widget.menus.length, (index) {
                        var item = widget.menus[index];
                        bool selected = index == selectedIndex;
                        if ((widget.menus.length / 2).floor() == index) {}
                        return Expanded(
                          child: InkWell(
                            onTap: () => updateIndex(index),
                            child: Container(
                              height: bottomBarHeight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    transform: Matrix4.translationValues(
                                        0.0, selected ? -20 : 10, 0),
                                    margin: EdgeInsets.only(
                                      bottom: selected ? 6.0 : 0,
                                    ),
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 200),
                                      opacity: selected ? 0.0 : 1.0,
                                      child: Icon(
                                        item.icon,
                                        color: selected
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey[700],
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    transform: Matrix4.translationValues(
                                        0.0, selected ? -16 : 20, 0),
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 200),
                                      opacity: selected ? 1.0 : 0.0,
                                      child: Text(
                                        "${item.label}",
                                        overflow: TextOverflow.ellipsis,
                                        key: Key("${Random().nextInt(1000)}"),
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (widget.mode == QNavigationMode.nav3) {
      return DefaultTabController(
        length: widget.pages.length,
        initialIndex: selectedIndex,
        child: Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: widget.pages,
          ),
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsets.all(0.0),
            shape: CircularNotchedRectangle(), // Membuat notch
            child: LayoutBuilder(builder: (context, constraints) {
              double mw = (constraints.maxWidth - 40);
              return Container(
                height: bottomBarHeight,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: 20 + ((mw / pageCount) * selectedIndex),
                      bottom: 0,
                      child: Container(
                        width: mw / pageCount,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      top: 0,
                      bottom: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(widget.menus.length, (index) {
                          var item = widget.menus[index];
                          bool selected = index == selectedIndex;
                          if ((widget.menus.length / 2).floor() == index) {}

                          return Expanded(
                            child: InkWell(
                              onTap: () => updateIndex(index),
                              child: Container(
                                height: bottomBarHeight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      margin: EdgeInsets.only(
                                        bottom: selected ? 6.0 : 0,
                                      ),
                                      child: AnimatedScale(
                                        duration: Duration(milliseconds: 200),
                                        scale: selected ? 1.2 : 1.0,
                                        child: Icon(
                                          item.icon,
                                          color: selected
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      );
    }

    if (widget.mode == QNavigationMode.docked) {
      return DefaultTabController(
        length: widget.pages.length,
        initialIndex: selectedIndex,
        child: Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: widget.pages,
          ),
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsets.all(0.0),
            notchMargin: 8,
            shape: CircularNotchedRectangle(), // Membuat notch
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                height: 58,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(widget.menus.length, (index) {
                    var item = widget.menus[index];
                    bool selected = index == selectedIndex;
                    bool middleIndex =
                        (widget.menus.length / 2).floor() - 1 == index;

                    double centerMargin = 30;

                    return Container(
                      width: (constraints.maxWidth - centerMargin) / pageCount,
                      margin: EdgeInsets.only(
                        right: middleIndex ? centerMargin : 0,
                      ),
                      child: AnimatedScale(
                        duration: Duration(milliseconds: 400),
                        scale: selected ? 1.2 : 1.0,
                        child: IconButton(
                          onPressed: () => updateIndex(index),
                          icon: Icon(
                            item.icon,
                            color: selected
                                ? Theme.of(context).primaryColor
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.4),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
          floatingActionButton: Container(
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {},
              child: Icon(Icons.point_of_sale),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      );
    }
    return Container();
  }
}
