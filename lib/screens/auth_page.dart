// ignore_for_file: prefer_const_constructors

import 'package:chat_app/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool _isLogin,
  ) async {
    // connect to firebase
    try {
      setState(() {
        _isLoading = true;
      });
      if (_isLogin == true) {
        var authResults = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        var authResults = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResults.user!.uid)
            .set({
          'username': username,
          'email': email,
          'uid': authResults.user!.uid,
        });
      }
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (error) {
      var message = 'An error occurred, Please check your credentials';

      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 1),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      var message = 'An error occurred, Please check your credentials';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 1),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        handleSubmit: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}
