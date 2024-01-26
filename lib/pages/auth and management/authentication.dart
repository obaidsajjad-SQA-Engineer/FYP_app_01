// ignore_for_file: unused_local_variable, unused_catch_clause

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user {
    return _auth.currentUser;
  }

  // SIGN UP METHOD
  Future<String?> signUp({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send verification email
      await userCredential.user?.sendEmailVerification();

      // Wait for the user to verify the email
      await _waitForEmailVerification(userCredential.user, email, password);

      // Save user data to Firestore with emailVerified field set to true
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'email': email,
        'password':
            password, // Note: Storing passwords in plaintext is not recommended. This is just an example.
        'name': name,
        'role': role,
      });

      return null; // Sign-up successful, return null for no error.
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/email-already-in-use') {
        return 'This email is already in use. Please use a different email.';
      } else {
        return e.message; // Other FirebaseAuthException errors
      }
    } catch (e) {
      return 'An unknown error occurred. Please try again later.';
    }
  }

  Future<void> _waitForEmailVerification(
      User? user, String email, String password) async {
    late Timer timer;
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
      }
    });
  }

  //SIGN OUT METHOD
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //SIGN IN METHOD
  Future<int> logIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        print('User ID: ${user.uid}');
        print('User Email: ${user.email}');
        // ... other user properties

        // Fetch the user role from Firestore
        String? userRole = await getUserRole(user.uid);

        if (userRole == "Patient") {
          if (user.emailVerified) {
            print("Email verified");
            return 1; // Successful sign-in
          } else {
            print("Email not verified");
            return 2; // Email not verified
          }
        } else {
          print("User is not a Patient");
          return 3; // User is not a Patient
        }
      } else {
        return 0; // Unexpected scenario
      }
    } on FirebaseAuthException catch (e) {
      return 0; // Failed sign-in
    }
  }

  Future<String?> getUserRole(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        return snapshot.data()?['role'];
      } else {
        return null; // Document does not exist
      }
    } catch (e) {
      print('Error fetching user role: $e');
      return null;
    }
  }

  // FORGOT PASSWORD METHOD
  Future<String?> forgotPassword({required String email}) async {
    try {
      // Fetch the user by email
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password:
            'dummy_password', // A temporary password, not used for authentication
      );

      User? user = userCredential.user;

      if (user != null) {
        // Fetch the user role from Firestore
        String? userRole = await getUserRole(user.uid);

        // Check if the user's role is "Patient"
        if (userRole == "Patient") {
          // Check if the user's email is verified
          if (user.emailVerified) {
            // Send password reset email
            await _auth.sendPasswordResetEmail(email: email);
            return null; // Password reset email sent successfully
          } else {
            return 'Email not verified. Please verify your email first.';
          }
        } else {
          return 'You are not authorized to reset the password.';
        }
      } else {
        return 'User not found. Please check your email and try again.';
      }
    } catch (e) {
      print('Error sending password reset email: $e');
      return 'An unknown error occurred. Please try again later.';
    }
  }
}
