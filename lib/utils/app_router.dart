import 'package:flutter/material.dart';

import 'package:vrouter/vrouter.dart';

class AppRouter {
  // If isReplacement is true, the history is replaced with this new route
  static void toHome(BuildContext context, {bool isReplacement = false}) {
    context.vRouter.to("/", isReplacement: isReplacement);
  }

  static void toRandom(BuildContext context) {
    context.vRouter.to("/random");
  }

  static void toFavorites(BuildContext context) {
    context.vRouter.to("/favorites");
  }
}
