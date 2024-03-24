import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AuthScreenProvider extends ChangeNotifier {
  bool isLoggedIn = false;
  bool isLoading = false;
  String errorMessage = "";
  User? user;
  String? displayName;
  String? displayEmail;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthScreenProvider() {
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      // Fetch user data if logged in
      await _fetchUserData();
    }
    notifyListeners();
  }

  Future<void> _fetchUserData() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .get();
      if (userData.exists && userData.data()!.containsKey('name')) {
        displayEmail = userData['email'];
        displayName = userData['name']; // Store the user's display name
        notifyListeners(); // Notify listeners that display name is updated
      } else {
        displayName = null; // User's name is not available
      }
    }
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        isLoggedIn = true;
        errorMessage = 'Login Successful!';
        showTopSnackBar(
          dismissType: DismissType.onSwipe,
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Logged in successfully !!",
          ),
        );
        notifyListeners();

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacementNamed(context, '/news');
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showTopSnackBar(
        dismissType: DismissType.onSwipe,
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Email or Password is Incorrect !!",
        ),
      );
      errorMessage = ("Error during sign-up: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUpWithEmailAndPassword(
      BuildContext context, String email, String password, String name) async {
    try {
      isLoading = true;
      notifyListeners();
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateProfile(displayName: name);
      String userId = userCredential.user!.uid;
      await _storeUserDataInFirestore(userId, email, name);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      isLoggedIn = true;
      notifyListeners();
      errorMessage = "Succesfully SignedUp !!";
      showTopSnackBar(
        dismissType: DismissType.onSwipe,
        Overlay.of(context),
        CustomSnackBar.success(
          message: "SignUp successfull !!",
        ),
      );
      notifyListeners();
      Navigator.pushReplacementNamed(context, '/news');
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showTopSnackBar(
        dismissType: DismissType.onSwipe,
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Email or Password is Incorrect !!",
        ),
      );
      errorMessage = ("Error during sign-up: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _storeUserDataInFirestore(
      String userId, String email, String name) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(userId).set({
        'email': email,
        'name': name,
      });
      print("User data stored in Firestore successfully!");
    } catch (e) {
      print("Error storing user data in Firestore: $e");
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await _auth.signOut();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      isLoggedIn = false;
      notifyListeners();

      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      print('Error signing out: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserNameAndPassword(
      BuildContext context, String newName, String password) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        final String userId = currentUser.uid;
        final CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        // Re-authenticate the user with their password
        AuthCredential credential = EmailAuthProvider.credential(
            email: currentUser.email!, password: password);
        await currentUser.reauthenticateWithCredential(credential);

        // Update the user's name in Firestore
        await users.doc(userId).update({
          'name': newName,
        });

        displayName = newName; // Update the displayName property
        showTopSnackBar(
          dismissType: DismissType.onSwipe,
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Succesfully Updated !!",
          ),
        );
        Navigator.pushReplacementNamed(context, '/profile');
        notifyListeners(); // Notify listeners that the display name is updated
      }
    } catch (e) {
      print('Error updating user name: $e');
      // Handle errors here (e.g., wrong password)
      // Show error message to the user
      showTopSnackBar(
        dismissType: DismissType.onSwipe,
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Password is Incorrect !!",
        ),
      );
    }
  }

 
}
