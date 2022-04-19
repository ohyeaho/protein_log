import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  final FirebaseAuth auth;

  FirebaseAuthentication(this.auth);

  Stream<User?> get authState => auth.idTokenChanges();

  Future<dynamic> signUp({String? name, String? email, String? password}) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      User? user = result.user;
      user!.updateDisplayName(name);
      print('successfully Registration');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 'error:exist';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn({String? email, String? password}) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      print('Successfully Singed In');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<bool> sendPasswordResetEmail({String? email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email!);
      print('success');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> delete() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('The user must reauthenticate before this operation can be executed.');
      }
    }
  }
}
