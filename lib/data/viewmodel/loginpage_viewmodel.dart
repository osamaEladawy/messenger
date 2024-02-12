import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:messenger/auth/internet_service.dart';
import 'package:messenger/core/service/myservice.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../auth/service_auth.dart';
import '../../views/auth/auth_page.dart';
import '../../views/screens/home_page.dart';
import '../../views/widgets/shared/nextpage.dart';
import '../../views/widgets/shared/snackbar.dart';

class LoginViewModel {
  String text1 = "Wellcome to Messenger App!";
  String text2 = "This is a nice app of Community 🎁";
  String text3 = "Sign in With Phone Number";
  String hint1 = 'Enter  your Number';
  String label = 'Phone Number';
  String password = 'Enter your password';
  String pass = 'Password';
  String button = 'Sign-In';
  String textEmail = "Sign in With Email";
  String hintEmail = 'Enter  your email';
  String labelEmail = 'Email';
  String not_A_Member = 'Not a member ?';
  String register = 'Register now';
  String sign_google = 'Sign In with Google';
  String sgin_face = 'Sign In with Facebook';
  String forgetMyPassword = "Forget password ? Click here";

  Myservice services = Myservice();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool sizeText = false;

  bool hiddenText = false;
  late void Function(void Function()) setState;

  changeState() {
    hiddenText = hiddenText == false ? true : false;
  }

  signIN(BuildContext context, String toEmail, String toPassword) async {
    if (formState.currentState!.validate()) {
      sizeText = false;
      final authService = Provider.of<AuthService>(context, listen: false);
      try {
        UserCredential userCredential =
            await authService.signINWithEmailAndPassword(toEmail, toPassword);

        if (userCredential.user!.emailVerified) {
          //  if(userCredential.user != null && services.preferences != null){
          //  services.preferences!.setString("id", userCredential.user!.uid);

          //   if(userCredential.user != null && userCredential.user!.displayName != null){
          //  services.preferences!.setString("name", userCredential.user!.displayName!);
          //  }

          //  if(userCredential.user!.email != null){
          //    services.preferences!.setString("email", userCredential.user!.email!);
          //  }

          //    if(userCredential.user != null && userCredential.user!.photoURL != null){
          //  services.preferences!.setString("image", userCredential.user!.photoURL!);
          //  }

          //  }
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const AuthPage(),
          ));
        } else {
          // ignore: use_build_context_synchronously
          return AwesomeDialog(
            dialogBackgroundColor: Colors.grey,
            descTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            barrierColor: Colors.white.withOpacity(0.8),
            context: context,
            title: "Haaaaaaye",
            desc: "please check your Gmail and send your email Validate",
            animType: AnimType.rightSlide,
            dialogType: DialogType.error,
            btnOkOnPress: () {
              Navigator.of(context).maybePop();
            },
          ).show();
        }
        return userCredential;
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
            backgroundColor: Colors.lightBlue,
          ),
        );
      }
    } else {
      sizeText = true;
      print("not valid");
    }
  }

  forgetPassword(BuildContext context, String email) async {
    if (email == "") {
      AwesomeDialog(
        dialogBackgroundColor: Colors.grey[900],
        titleTextStyle: const TextStyle(color: Colors.white),
        descTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        barrierColor: Colors.white.withOpacity(0.8),
        context: context,
        title: "Haaaaaaye",
        desc: "please required your email",
        animType: AnimType.rightSlide,
        dialogType: DialogType.error,
        btnOkOnPress: () {
          Navigator.of(context).maybePop();
        },
      ).show();
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        dialogBackgroundColor: Colors.grey[900],
        titleTextStyle: const TextStyle(color: Colors.white),
        descTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        barrierColor: Colors.white.withOpacity(0.8),
        context: context,
        title: "Welcome",
        desc: "please check your Gmail and send your create new password",
        animType: AnimType.rightSlide,
        dialogType: DialogType.success,
        btnOkOnPress: () {
          Navigator.of(context).maybePop();
        },
      ).show();
    } catch (e) {
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        dialogBackgroundColor: Colors.grey[900],
        titleTextStyle: const TextStyle(color: Colors.white),
        descTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        barrierColor: Colors.white.withOpacity(0.8),
        context: context,
        title: "Haaaaaaye",
        desc: "please check your email",
        animType: AnimType.rightSlide,
        dialogType: DialogType.error,
        btnOkOnPress: () {
          Navigator.of(context).maybePop();
        },
      ).show();
    }
  }

  Future<void> handleFacebookSignIn(BuildContext context,
      RoundedLoadingButtonController facebookController) async {
    final authService = context.read<AuthService>();
    //Provider.of<GoogleServise>(context, listen: false);
    final internetServise = context.read<InternetServise>();
    //Provider.of<InternetServise>(context, listen: false);
    await internetServise.checkInternetConnection();

    if (internetServise.hasInternet == false) {
      // ignore: use_build_context_synchronously
      openSnackBar(context, "check your internet connection", Colors.red);
      facebookController.reset();
    } else {
      await authService.signInWithFacebook().then((value) {
        if (authService.hasError == true) {
          if (kDebugMode) {
            print(authService.errorCode.toString());
          }
          openSnackBar(context, authService.errorCode.toString(), Colors.red);
          facebookController.reset();
        } else {
          //check whether user exists or not
          authService.checkUerExists().then((value) async {
            if (value == true) {
              if (kDebugMode) {
                print(authService.errorCode.toString());
              }
              if (kDebugMode) {
                print(value.toString());
              }
              await authService.getUserDataFromFirestore(authService.uid).then(
                    (value) =>
                        authService.saveUserDataToSharedPreferences().then(
                              (value) => authService.setSignIn().then(
                                (value) {
                                  facebookController.success();
                                  handleAfterSignIn(context);
                                },
                              ),
                            ),
                  );
            } else {
              //check if user not exists
              authService.saveUserDataToFirestore().then(
                    (value) =>
                        authService.saveUserDataToSharedPreferences().then(
                              (value) => authService.setSignIn().then((value) {
                                if (kDebugMode) {
                                  print(authService.errorCode.toString());
                                }
                                if (kDebugMode) {
                                  print(value.toString());
                                }
                                facebookController.success();
                                handleAfterSignIn(context);
                              }),
                            ),
                  );
            }
          });
        }
      });
    }
  }

  handleAfterSignIn(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplacement(context, const HomePage());
    });
  }

  //handling google sign in
  Future<void> handlegoogleSignIn(BuildContext context,
      RoundedLoadingButtonController buttonController) async {
    final authServise = context.read<AuthService>();
    //Provider.of<GoogleServise>(context, listen: false);
    final internetServise = context.read<InternetServise>();
    //Provider.of<InternetServise>(context, listen: false);
    await internetServise.checkInternetConnection();

    if (internetServise.hasInternet == false) {
      // ignore: use_build_context_synchronously
      openSnackBar(context, "check your internet connection", Colors.red);
      buttonController.reset();
    } else {
      await authServise.signInWithGoogle().then((value) {
        if (authServise.hasError == true) {
          // print(authServise.errorCode.toString());
          openSnackBar(context, authServise.errorCode.toString(), Colors.red);
          buttonController.reset();
        } else {
          //check whether user exists or not
          authServise.checkUerExists().then((value) async {
            if (value == true) {
              await authServise.getUserDataFromFirestore(authServise.uid).then(
                    (value) =>
                        authServise.saveUserDataToSharedPreferences().then(
                              (value) => authServise.setSignIn().then(
                                (value) {
                                  buttonController.success();
                                  handleAfterSignIn(context);
                                },
                              ),
                            ),
                  );
            } else {
              //check if user not exists
              authServise.saveUserDataToFirestore().then(
                  (value) => authServise.saveUserDataToSharedPreferences().then(
                        (value) => authServise.setSignIn().then((value) {
                          buttonController.success();
                          handleAfterSignInONe(context);
                        }),
                      ));
            }
          });
        }
      });
    }
  }

  handleAfterSignInONe(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplacement(context, const HomePage());
    });
  }
}
