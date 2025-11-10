import 'package:flutter/material.dart';
import 'package:green_sense/widgets/navigation/responsive_app_bar.dart';
import 'package:green_sense/widgets/navigation/mobile_drawer.dart';
import 'package:green_sense/widgets/footer.dart';
import 'package:green_sense/utils/responsive.dart';

class PageScaffold extends StatelessWidget {
  final Widget body;
  final bool showFooter;

  const PageScaffold({
    Key? key,
    required this.body,
    this.showFooter = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ResponsiveAppBar(),
      drawer: Responsive.isMobile(context) ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            body,
            if (showFooter) const Footer(),
          ],
        ),
      ),
    );
  }
}
