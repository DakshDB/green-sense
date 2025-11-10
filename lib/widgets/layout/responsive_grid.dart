import 'package:flutter/material.dart';
import 'package:green_sense/utils/responsive.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;

  const ResponsiveGrid({
    Key? key,
    required this.children,
    this.spacing = 20,
    this.runSpacing = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int crossAxisCount;

    if (Responsive.isMobile(context)) {
      crossAxisCount = 1;
    } else if (Responsive.isTablet(context)) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 3;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: runSpacing,
        childAspectRatio: 0.85,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
