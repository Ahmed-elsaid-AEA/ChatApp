// ignore: file_names
import 'package:chatapp/shared/helper/SnackBarShowenClass.dart';
import 'package:chatapp/shared/components/CustomFormTextField.dart';
import 'package:chatapp/shared/components/CustomMaterialButton.dart';
import 'package:chatapp/shared/helper/Validate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chatapp/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? email, password;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoadingModalProgressHud = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoadingModalProgressHud, //shown or not
        child: Scaffold(
          backgroundColor: kMainColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        kLogoImage,
                        width: 150,
                        height: 150,
                      ),
                      const Text(
                        textAlign: TextAlign.center,
                        "Chat App",
                        style: TextStyle(
                            fontFamily: kFontFasthand,
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomFormTextField(
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
                        onChanged: (value) => email = value,
                        prefixIcon: Icons.email,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Enter Your Email";
                          } else if (!Validate().emilValidation(email!.trim())) {
                            return "Not Email";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomFormTextField(
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Enter Your password";
                          } else if (value.trim().length < 8) {
                            return "Should At least 8 chatacters";
                          }
                        },
                        onChanged: (value) => password = value,
                        labelText: 'Password',
                        hintText: 'Enter Your Password',
                        prefixIcon: Icons.password,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomFormTextField(
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Enter Your Confirm Password";
                          } else if (value.trim().toString() != password) {
                            return "Password And Confirm Password Not Matched";
                          }
                        },
                        labelText: 'Confirm Password',
                        hintText: 'Enter Your Confirm Password',
                        prefixIcon: Icons.password,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomMaterialButton(
                        textButton: 'Sign Up',
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              isLoadingModalProgressHud = true;
                            });

                            try {
                              CircularProgressIndicator();
                              await registerUser().then((value) {
                                setState(() {
                                  isLoadingModalProgressHud = false;

                                });
                                Navigator.pushNamed(context, kChatPageScreen,arguments: email);
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                SnackBarShowenClass().showSnackBar(context,
                                    'The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                SnackBarShowenClass().showSnackBar(context,
                                    'The account already exists for that email.');
                              }
                            } catch (ex) {
                              SnackBarShowenClass()
                                  .showSnackBar(context, ex.toString());
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account?',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Log in',
                                style: const TextStyle(
                                    color: Color(0xff31E1F7), fontSize: 20),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
