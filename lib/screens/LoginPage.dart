import 'package:chatapp/shared/helper/SnackBarShowenClass.dart';
import 'package:chatapp/shared/components/CustomFormTextField.dart';
import 'package:chatapp/shared/components/CustomMaterialButton.dart';
import 'package:chatapp/shared/components/CustomTextField.dart';
import 'package:chatapp/shared/constants.dart';
import 'package:chatapp/shared/helper/Validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email;

  String? password;

  bool isLoadingModalProgressHud = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoadingModalProgressHud,
        child: Scaffold(
          backgroundColor: kMainColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
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
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomFormTextField(
                        onChanged: (value) => email = value,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Enter Your Email";
                          } else if (!Validate().emilValidation(email!)) {
                            return "Not Email";
                          }
                        },
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
                        prefixIcon: Icons.email,
                        prefixIconColor: Colors.white,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomFormTextField(
                        onChanged: (value) => password = value,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Enter Your password";
                          } else if (value.trim().length < 8) {
                            return "Should At least 8 chatacters";
                          }
                        },
                        labelText: 'Password',
                        hintText: 'Enter Your password',
                        prefixIcon: Icons.password,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomMaterialButton(
                        textButton: 'Login',
                        onPressed: () async {
                          try {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoadingModalProgressHud = true;
                              });
                              await loginUser().then((value) {
                                setState(() {

                                });

                                Navigator.pushNamed(context, kChatPageScreen,arguments: email);
                              });
                            }
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'wrong-password') {
                              SnackBarShowenClass().showSnackBar(
                                  context, 'wrong-password');
                            }else if (ex.code == 'user-disabled') {
                              SnackBarShowenClass().showSnackBar(
                                  context, 'user-disabled');
                            }else if (ex.code == 'invalid-email') {
                              SnackBarShowenClass().showSnackBar(
                                  context, 'invalid-email');
                            }else if (ex.code == 'user-not-found') {
                              SnackBarShowenClass().showSnackBar(
                                  context, 'user-not-found');
                            }
                          } catch (e) {
                            print(e);
                          }
                          setState(() {
                            isLoadingModalProgressHud=false;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Sign up',
                                style: const TextStyle(
                                    color: Color(0xff31E1F7), fontSize: 20),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.pushNamed(
                                      context, kSignUpPageScreen),
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

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
