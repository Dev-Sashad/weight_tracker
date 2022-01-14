import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:weight_traker/utils/constants/colors.dart';
import 'package:weight_traker/utils/enums.dart';
import 'package:weight_traker/view/authViews/login/loginpage.dart';
import 'package:weight_traker/view/homepage/homepage.dart';
import 'package:weight_traker/view/splashscreens/splashscreen_view_model.dart';

class SplashscreenView extends StatelessWidget {
  //const SplashscreenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SplashscreenViewModel>.withConsumer(
        viewModelBuilder: () => SplashscreenViewModel(),
        onModelReady: (v) => v.isuserloggedin(),
        builder: (context, model, child) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: AnimatedSplashScreen(
                  centered: true,
                  backgroundColor: AppColors.primaryColor,
                  splash: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('asset/images/health.png'),
                                fit: BoxFit.fill)),
                      ),
                      Text(
                        'WEIGHT TRACKER',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      ),
                    ],
                  ),
                  splashIconSize: 200,
                  splashTransition: SplashTransition.scaleTransition,
                  nextScreen: FutureBuilder<dynamic>(
                    builder: (context, snapshot) {
                      if (model.status == LoggedInStatus.loggedOut) {
                        return LogInPage();
                      } else {
                        return Homepage();
                      }
                    },
                  )),
            ),
          );
        });
  }
}
