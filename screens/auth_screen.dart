import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widgets/auth/AuthForm.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  void _submitAuthForm(String email, String password, String username, File image,
      bool isLogin, BuildContext ctx) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if(isLogin){
        // ignore: unused_local_variable

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      }else{
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final ref=FirebaseStorage.instance.ref().child("user_image").child(userCredential.user!.uid+".jpg");
      await ref.putFile(image);
      final url=await ref.getDownloadURL();
      FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set({
        "username":username,
        "email":email,
        "image_url":url,
      });
      }
    } on FirebaseAuthException catch (e) {
      var message = "An error occurred, please check your credentials!";
      if (e.code == 'weak-password') {
        message="The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        message="The account already exists for that email";
      }
      else if (e.code == 'user-not-found') {
        message="No user found for that email";
      } else if (e.code == 'wrong-password') {
        message="Wrong password provided for that user";
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),


      );
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AuthForm(_submitAuthForm,_isLoading),
    );
  }
}
