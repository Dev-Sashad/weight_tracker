import 'package:weight_traker/core/services/auth_service.dart';
import 'package:weight_traker/core/services/firestoreServices.dart';
import 'package:weight_traker/utils/baseModel/baseModel.dart';
import 'package:weight_traker/utils/constants/helpers.dart';
import 'package:weight_traker/utils/constants/locator.dart';
import 'package:weight_traker/utils/dialogeManager/dialogService.dart';
import 'package:weight_traker/utils/router/navigationService.dart';
import 'package:weight_traker/utils/router/routeNames.dart';

class HomepageVm extends BaseModel {
  // final FireStoreService _firestoreService = locator<FireStoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authentication = locator<AuthService>();
  final ProgressService _progressService = locator<ProgressService>();
  final FireStoreService _fireStoreService = locator<FireStoreService>();

  String _name = '';
  String get name => _name;
  setName() {
    _name = _authentication.name;
    notifyListeners();
  }

  void navigateToWeight() {
    _navigationService.navigateTo(WeightHistroyRoute);
  }

  submitForm(String weight) async {
    setBusy(true);
    try {
      var isConnected = await checkInternet();
      if (isConnected == false) {
        setBusy(false);
        _progressService.showDialog(
            title: 'No Connection!',
            description: 'Please check your internet connection!');
      } else {
        checkSession().then((value) {
          _fireStoreService.submitWeight(weight).whenComplete(() async {
            setBusy(false);
            await _progressService.showDialog(
                title: 'Success', description: 'Succesfully submitted');
          });
        });
      }
    } catch (e) {
      print(e);
      setBusy(false);
      _progressService.showDialog(
          title: 'oops!', description: 'An occured, try again!');
    }
  }
}
