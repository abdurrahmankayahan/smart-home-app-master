import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart360/helper/helper_function.dart';
import 'package:smart360/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart360/src/models/data_models/userModel.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // register
  Future registerUserWithEmailandPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // call our database service to update the user data.
      await DatabaseService(uid: user.uid).savingUserData(name, email);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //signout
  Future signOut() async {
    try {
      HelperFunctions hlp=HelperFunctions();
      hlp.initSP();
      hlp.setUserInfo(UserModel());


      // await HelperFunctions.saveUserLoggedInStatus(false);
      // await HelperFunctions.saveUserEmailSF("");
      // await HelperFunctions.saveUserNameSF("");


      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

  Stream<User?> get authStateChanges => firebaseAuth.idTokenChanges();

  final _firestore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser;
  //veri gosterme fonksiyonu
  Stream<QuerySnapshot> getUsers() {
    var ref = _firestore
        .collection("users")
        .doc(_currentUser!.uid)
        .collection('leaveRequests')
        .snapshots();

    return ref;
  }

  // veri silme fonksiyonu
  Future<void> removeStatus(String docId) async {
    var ref = _firestore.collection("users").doc(docId).delete();

    return ref;
  }
}
