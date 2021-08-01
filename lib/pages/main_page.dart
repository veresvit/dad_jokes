import 'package:dad_jokes_demo/utils/app_router.dart';
import 'package:dad_jokes_demo/widgets/app_bar.dart';
import 'package:dad_jokes_demo/widgets/spacers.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'Main menu'),
      body: Center(
        child: Column(
          children: [
            pad2(),
            Text(
              'Welcome to the Dad jokes demo site! Continue to your favorite jokes or get a random one.',
              textAlign: TextAlign.center,
            ),
            pad2(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => AppRouter.toFavorites(context),
                  child: Text('Favorite jokes'),
                ),
                pad2(),
                ElevatedButton(
                  onPressed: () => AppRouter.toRandom(context),
                  child: Text('Get a random joke'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
