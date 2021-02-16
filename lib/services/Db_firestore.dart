import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';

class DbProvider {
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  final Map<String, dynamic> defaultDataMap = {
    'taken': false,
    'taker': 'None',
    'completed': false,
    'uid': ''
  };
  String userName;

  DbProvider() {
    firebase.enableNetwork();
  }

  addUserName(String userName, String userId) async {
    await firebase.collection("usernames").add(
      {"username": "$userName", "userId": "$userId"},
    );
  }

  updateDocumentForTaken(String collection, index, bool value) async {
    var temp = await firebase
        .collection('$collection')
        .doc('Para ${index + 1}')
        .update({"taken": value});
    return temp;
  }

  updateDocumentForCompl(String collection, index, bool value) async {
    await firebase
        .collection('$collection')
        .doc('Para ${index + 1}')
        .update({"completed": value});
  }

  updateDocumentForTaker(String collection, index, String name) async {
    await firebase
        .collection('$collection')
        .doc('Para ${index + 1}')
        .update({"taker": name});
  }

  updateDocumentForTakerUid(String collection, index, String id) async {
    await firebase
        .collection('$collection')
        .doc('Para ${index + 1}')
        .update({"uid": id});
  }

  Future<String> getUserName() async {
    if (userName != null) return Future.value(userName);

    final list = await firebase.collection('usernames').get();

    for (var username in list.docs) {
      if (auth.getCurrentUserId() == username['userId']) {
        userName = username['username'];
        return username['username'];
      }
    }

    return null;
  }

  Future<bool> checkAdmin() async {
    var admin = await firebase
        .collection('admins')
        .where('userId', isEqualTo: auth.getCurrentUserId())
        .get();
    print('THi ${admin.toString()}');

    if (admin.docs.isEmpty || admin.docs == [] || admin == null) return false;
    return true;
  }

  Future<int> initCollection() async {
    await _deleteCollection().then((value) async {
      for (var i = 1; i < 31; i++) {
        await firebase.collection('Quran1').doc('Para $i').set({
          'taken': false,
          'taker': 'None',
          'completed': false,
          'ID': i,
          'uid': ''
        });
      }

      for (var i = 1; i < 31; i++) {
        await firebase.collection('Quran2').doc('Para $i').set({
          'taken': false,
          'taker': 'None',
          'completed': false,
          'ID': i,
          'uid': ''
        });
      }
    });

    return 1;
  }

  Future<int> _deleteCollection() async{
    await firebase.collection('Quran1').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    await firebase.collection('Quran2').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    return Future.value(1);
  }
}

final db = DbProvider();
