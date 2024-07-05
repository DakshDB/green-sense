import 'package:flutter/material.dart';

import 'tab_title.dart';

class Header extends StatelessWidget {
  final Future<dynamic> Function(int) scrollToIndex;
  const Header({Key? key, required this.scrollToIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.centerRight,
      width: size.width * 0.5,
      child: DefaultTabController(
        length: 2,
        child: TabBar(
          isScrollable: true,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          onTap: (index) {
            scrollToIndex(index + 1);
          },
          tabs: const [
            Tab(
              child: TabTitle(
                text: 'About',
              ),
            ),
            Tab(
              child: TabTitle(
                text: 'Contact',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
