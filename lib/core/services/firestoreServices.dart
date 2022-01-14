import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_traker/core/model/success_model.dart';
import 'package:weight_traker/utils/constants/locator.dart';
import 'auth_service.dart';

class FireStoreService {
  final firestoreInstance = FirebaseFirestore.instance;
  final AuthService _authentication = locator<AuthService>();
  Future<dynamic> submitWeight(String weight) async {
    print('weight is $weight');
    String date = DateTime.now().toString();

    firestoreInstance.runTransaction((Transaction transaction) async {
      CollectionReference reference = firestoreInstance
          .collection('user')
          .doc(_authentication.uid)
          .collection('weight');
      await reference.add({
        "dateTime": date,
        "weight": weight,
      });
    }).then((value) async {
      return SuccessModel(value);
    }).onError((error, stackTrace) {
      return error;
    });
  }

  Future<dynamic> updateWeight(String weight, String id) async {
    print('weight is $weight');
    String date = DateTime.now().toString();

    DocumentReference reference = FirebaseFirestore.instance
        .collection('user')
        .doc(_authentication.uid)
        .collection('weight')
        .doc(id);
    await reference.update({
      "dateTime": date,
      "weight": weight,
    });
  }

  Future<dynamic> deleteWeight(String documentId) async {
    print(documentId);
    DocumentReference reference = FirebaseFirestore.instance
        .collection('user')
        .doc(_authentication.uid)
        .collection('weight')
        .doc(documentId);
    await reference.delete();
  }

  getMyWeight() {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(_authentication.uid)
        .collection('weight')
        .orderBy('dateTime', descending: true)
        .snapshots();
  }
}
