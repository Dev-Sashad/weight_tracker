import 'package:weight_traker/core/services/auth_service.dart';
import 'package:weight_traker/utils/baseModel/baseModel.dart';
import 'package:weight_traker/utils/constants/helpers.dart';
import 'package:weight_traker/utils/constants/locator.dart';
import 'package:weight_traker/utils/dialogeManager/dialogService.dart';
import 'package:weight_traker/utils/enums.dart';

class SplashscreenViewModel extends BaseModel {
  final AuthService _authentication = locator<AuthService>();
  final ProgressService _progressService = locator<ProgressService>();
  LoggedInStatus _status;
  LoggedInStatus get status => _status;
  isuserloggedin() async {
    try {
      checkSession().then((value) async {
        var isConnected = await checkInternet();
        if (isConnected == false) {
          _status = LoggedInStatus.loggedOut;
          _progressService.showDialog(
              title: 'No Connection!',
              description: 'Please check your internet connection!');
        } else {
          var data = await _authentication.getCurrentUser();
          print(data);
          _status = data;
        }
        notifyListeners();
      });
    } catch (e) {
      _status = LoggedInStatus.loggedOut;
      notifyListeners();
    }
  }
}
