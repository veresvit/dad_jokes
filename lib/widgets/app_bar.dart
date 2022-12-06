import 'package:badges/badges.dart';
import 'package:dad_jokes_demo/data/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:dad_jokes_demo/utils/app_router.dart';
import 'package:dad_jokes_demo/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final double elevation;

  final List<Widget> actions;

  const MainAppBar({
    Key? key,
    required this.title,
    this.elevation = 4,
    this.actions = const [],
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      elevation: elevation,
      backgroundColor: AppColors.cardColor,
      centerTitle: false,
      title: InkWell(
        child: Text(title),
        onTap: () => AppRouter.toHome(context),
      ),
      actions: [...actions, _FavoritesIcon()],
      iconTheme: IconThemeData(
        color: AppColors.text,
      ),
      actionsIconTheme: IconThemeData(
        color: AppColors.text,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarTextStyle: Theme.of(context)
          .textTheme
          .apply(
            bodyColor: AppColors.text,
          )
          .bodyText2,
      titleTextStyle: Theme.of(context)
          .textTheme
          .apply(
            bodyColor: AppColors.text,
          )
          .headline6,
    );
  }
}

class _FavoritesIcon extends StatelessWidget {
  const _FavoritesIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) => state.map(
        initial: (state) => ElevatedButton(onPressed: null, child: CircularProgressIndicator()),
        loadInProgress: (state) => ElevatedButton(onPressed: null, child: CircularProgressIndicator()),
        loadFailure: (state) => Container(),
        loadSuccess: (state) {
          return IconButton(
            onPressed: () => AppRouter.toFavorites(context),
            icon: Badge(
              child: Icon(Icons.favorite),
              badgeContent: Text("${state.favoriteJokes.length}"),
              showBadge: state.favoriteJokes.isNotEmpty,
            ),
          );
        },
      ),
    );
  }
}
