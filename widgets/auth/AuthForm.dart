import 'dart:io';

import 'package:flutter/material.dart';

import '../picker/user_image_picket.dart';


class AuthForm extends StatefulWidget {

  final void Function(String email, String password, String username,File image,
      bool isLogin, BuildContext ctx) submitFn;
  final bool isLoading;


  AuthForm(this.submitFn,this.isLoading );

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = "";
  var _userPassword = "";
  var _userName = "";
   File? _userImageFile;

  void _pickImage(File  pickedImage){
    _userImageFile=pickedImage;
  }
  void _trySubmit() {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please pick an image"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    if (isValid) {
      _formkey.currentState!.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(), _userImageFile!,
          _isLogin, context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              margin: EdgeInsets.only(top: 70),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 64),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.purple,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                "MyChat",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontFamily: "Anton",
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              child: Center(
              child: Card(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin) UserImagePicker(_pickImage),
                          TextFormField(
                            autocorrect: false,
                            enableSuggestions: false,
                            textCapitalization: TextCapitalization.none,
                            key: ValueKey("email"),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains("@")) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(labelText: "Email Address"),
                            onSaved: (value) {
                              _userEmail = value!;
                            },
                          ),
                          if (!_isLogin)
                            TextFormField(
                              autocorrect: true,
                              enableSuggestions: false,
                              textCapitalization: TextCapitalization.words,

                              key: ValueKey("username"),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 4) {
                                  return "Please enter at least 4 characters";
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: "Username"),
                              onSaved: (value) {
                                _userName = value!;
                              },
                            ),
                          TextFormField(
                            key: ValueKey("password"),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return "Password must be at least 7 characters long";
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: "Password"),
                            obscureText: true,
                            onSaved: (value) {
                              _userPassword = value!;
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
if(widget.isLoading)
                            CircularProgressIndicator(),
                          if(!widget.isLoading)

                          ElevatedButton(
style: Theme.of(context).elevatedButtonTheme.style,
                            onPressed: _trySubmit,
                            child: Text(_isLogin ? "Login" : "Signup"),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? "Create new account"
                                : "I already have an account"),
                          )
                        ],
                      )),
                  ),
                ),

    ),
            ),
          ],
        ),
      );
  }
}
