import 'package:flutter/material.dart';
import 'package:green_sense/screens/about.dart';
import 'package:green_sense/screens/contact.dart';
import 'package:green_sense/screens/introduction.dart';
import 'package:green_sense/widgets/header.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scrollDirection = Axis.vertical;

  late AutoScrollController _autoScrollController;
  bool isExpanded = true;

  Future scrollToIndex(int index) async {
    await _autoScrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
    _autoScrollController.highlight(index);
  }

  @override
  void initState() {
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection,
    );
    super.initState();
  }

  Widget _wrapScrollTag({int? index, Widget? child}) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: _autoScrollController,
      index: index!,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xfff7fcf7),
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Image.asset("images/logo.png", height: 60),
                        hoverColor: Colors.transparent,
                        onPressed: () {
                          scrollToIndex(0);
                        }),
                    Header(
                      scrollToIndex: scrollToIndex,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                height: size.height * 0.9,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        controller: _autoScrollController,
                        slivers: <Widget>[
                          SliverList(
                              delegate: SliverChildListDelegate([
                            _wrapScrollTag(
                              index: 0,
                              child: const Introduction(),
                            ),
                            _wrapScrollTag(
                              index: 1,
                              child: const About(),
                            ),
                            _wrapScrollTag(
                              index: 2,
                              child: const Contact(),
                            ),
                          ]))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
