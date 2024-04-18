import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/core/theme/style.dart';
import 'package:messenger_app/view/widgets/auth/button_auth.dart';
import 'package:messenger_app/view/widgets/auth/dialog_exit.dart';
import 'package:messenger_app/view/widgets/auth/ifyou_have_account.dart';
import 'package:messenger_app/view/widgets/auth/textformfield.dart';
import 'package:messenger_app/view_model/auth/login.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginViewModel _model = LoginViewModel();

  @override
  void dispose() {
    _model.email;
    _model.password;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: HaveAccountOrCreateIt(
          onTap: widget.onTap, title: "Sign Up", isHaveAccount: false),
      body: PopScope(
        canPop: false,
        onPopInvoked: (b) {
          showDialog(
            context: context,
            builder: (context) => const ExitDialog(),
          );
        },
        child: SingleChildScrollView(
          child: Form(
            key: _model.myKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const Text(
                    "Messenger",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      // color: buttonColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset(
                      "assets/images/messenger1.png",
                      height: 120,
                      width: 120,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  CustomTextFormField(
                    controller: _model.email,
                    icon: Icons.email,
                    obscureText: true,
                    hintText: "Enter Your email",
                    labelText: "Email",
                  ),
                  CustomTextFormField(
                    controller: _model.password,
                    icon: Icons.visibility,
                    obscureText: _model.isShowText,
                    onTap: () {
                      _model.showOrHiddenText();
                      setState(() {});
                    },
                    hintText: "Enter Your Password",
                    labelText: "password",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                activeColor: buttonLoginColor,
                                value: _model.isCheck,
                                onChanged: (newValue) {
                                  _model.isCheck = newValue!;
                                  setState(() {});
                                }),
                            const Text(
                              "Remember Me",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: buttonLoginColor),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () async {
                            await _model.forgetPassword(context: context);
                          },
                          child: const Text(
                            "Forget Password ?",
                            style: TextStyle(
                              color: buttonLoginColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButtonAuth(
                      onTap: () async {
                        _model.login(context: context);
                      },
                      title: "LOG IN",
                      color: const Color(0xFF2196F3)),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Or Login",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {},
                        label: const Text(
                          "Facebook",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        icon: const Icon(
                          Icons.facebook,
                          color: Colors.blue,
                        ),
                      ),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          disabledBackgroundColor: buttonColor,
                        ),
                        onPressed: () {},
                        label: const Text(
                          "Google",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        icon: const Icon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
