import 'package:flutter/material.dart';
import 'package:weight_traker/utils/router/routeNames.dart';
import 'package:weight_traker/view/authViews/SignUp/signup.dart';
import 'package:weight_traker/view/authViews/login/loginpage.dart';
import 'package:weight_traker/view/authViews/resetpassword/resetpassword.dart';
import 'package:weight_traker/view/homepage/homepage.dart';
import 'package:weight_traker/view/weight_entries/weight_history.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignInPageRoute:
      return _getPageRoute(
        routeName: settings.name ?? "",
        viewToShow: LogInPage(),
      );

    case SignUpPageRoute:
      return _getPageRoute(
        routeName: settings.name ?? "",
        viewToShow: SignUpView(),
      );

    case HomePageRoute:
      return _getPageRoute(
        routeName: settings.name ?? "",
        viewToShow: Homepage(),
      );

    case ResetPasswordRoute:
      return _getPageRoute(
        routeName: settings.name ?? "",
        viewToShow: ResetPasswordpage(),
      );

    case WeightHistroyRoute:
      return _getPageRoute(
        routeName: settings.name ?? "",
        viewToShow: WeightHistory(),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, @required Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
