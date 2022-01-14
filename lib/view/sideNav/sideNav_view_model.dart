import 'package:url_launcher/url_launcher.dart';
import 'package:weight_traker/core/services/auth_service.dart';
import 'package:weight_traker/utils/baseModel/baseModel.dart';
import 'package:weight_traker/utils/constants/locator.dart';
import 'package:weight_traker/utils/router/navigationService.dart';
import 'package:weight_traker/utils/router/routeNames.dart';

class SideNavViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authentication = locator<AuthService>();

  void pop() {
    _navigationService.pop();
  }

  void navigateToWeight() {
    _navigationService.navigateTo(WeightHistroyRoute);
  }

  void navigateToResetPassword() {
    _navigationService.navigateTo(ResetPasswordRoute);
  }

  call() {
    return launch("tel://+2348035853226");
  }

  void signout() async {
    await _authentication.signOut();
    _navigationService.navigateReplacementTo(SignInPageRoute);
  }
}
