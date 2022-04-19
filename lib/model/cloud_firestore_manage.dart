import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreManage {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference firestoreCollectionUsers = FirebaseFirestore.instance.collection('users');

  /// 新規ユーザ作成
  Future<void> setUserAccount({
    required String name,
  }) {
    return firestoreCollectionUsers
        .doc(currentUser!.uid)
        .set({
          'name': name,
          'createAt': Timestamp.now(),
        })
        .then((value) => print('account add successfully'))
        .catchError((e) => print('failed to add account: $e'));
  }
}
