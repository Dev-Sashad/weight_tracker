//import 'package:firebase_auth/firebase_auth.dart';

import 'package:weight_traker/core/services/firestoreServices.dart';
import 'package:weight_traker/utils/baseModel/baseModel.dart';
import 'package:weight_traker/utils/constants/helpers.dart';
import 'package:weight_traker/utils/constants/locator.dart';
import 'package:weight_traker/utils/dialogeManager/dialogService.dart';
import 'package:weight_traker/utils/router/navigationService.dart';

class BookingHistoryVm extends BaseModel {
  final FireStoreService _fireStoreService = locator<FireStoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ProgressService _progressService = locator<ProgressService>();

  getweight() {
    return _fireStoreService.getMyWeight();
  }

  delete(String documentId) async {
    setBusy(true);
    try {
      var isConnected = await checkInternet();
      if (isConnected == false) {
        setBusy(false);
        _progressService.showDialog(
            title: 'No Connection!',
            description: 'Please check your internet connection!');
      } else {
        _fireStoreService
            .deleteWeight(documentId)
            .whenComplete(() => setBusy(false));
      }
    } catch (e) {
      print(e);
      setBusy(false);
      _progressService.showDialog(
          title: 'oops!', description: 'An occured, try again!');
    }
  }

  pop() {
    _navigationService.pop();
  }
}
