import 'package:weight_traker/utils/baseModel/baseModel.dart';
import 'package:weight_traker/core/services/firestoreServices.dart';
import 'package:weight_traker/utils/constants/helpers.dart';
import 'package:weight_traker/utils/constants/locator.dart';
import 'package:weight_traker/utils/dialogeManager/dialogService.dart';
import 'package:weight_traker/utils/router/navigationService.dart';

class EditWeightVm extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ProgressService _progressService = locator<ProgressService>();
  final FireStoreService _fireStoreService = locator<FireStoreService>();

  void pop() {
    _navigationService.pop();
  }

  submitForm(String weight, String id) async {
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
          _fireStoreService.updateWeight(weight, id).whenComplete(() async {
            setBusy(false);
            await _progressService
                .showDialog(title: 'Success', description: 'Update Succesfull')
                .then((value) => pop());
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
