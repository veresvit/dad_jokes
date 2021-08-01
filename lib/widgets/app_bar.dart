import 'package:dad_jokes_demo/values/app_colors.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final double elevation;

  final List<Widget>? actions;

  const MainAppBar({
    Key? key,
    required this.title,
    this.elevation = 4,
    this.actions,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      elevation: elevation,
      backgroundColor: AppColors.cardColor,
      centerTitle: false,
      title: Text(title),
      actions: actions,
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: AppColors.text,
      ),
      actionsIconTheme: IconThemeData(
        color: AppColors.text,
      ),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColors.text,
          ),
    );
  }
}
