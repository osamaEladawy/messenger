import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/core/class/handel_image.dart';
import 'package:messenger_app/core/theme/style.dart';
import 'package:messenger_app/views/widgets/auth/button_auth.dart';
import 'package:messenger_app/views/widgets/auth/dialog_exit.dart';
import 'package:messenger_app/views/widgets/auth/ifyou_have_account.dart';
import 'package:messenger_app/views/widgets/auth/textformfield.dart';
import 'package:messenger_app/view_model/auth/sign_up.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final void Function()? onTap;

  const SignUp({super.key, this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SignUpViewModel _model = SignUpViewModel();

  @override
  void dispose() {
    _model.name.dispose();
    _model.email.dispose();
    _model.password.dispose();
    _model.confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<HandleImage>(context);
    return Scaffold(
      bottomNavigationBar: HaveAccountOrCreateIt(
        onTap: widget.onTap,
        title: 'Login',
        isHaveAccount: true,
      ),
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(top: 25,right: 30),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Text("Sign Up")),
              Divider(),
            ],
          ),
        ),
      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: const Text(
                      "Create Your Account",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    "please enter your info to create account",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: service.profileImage(false),
                      ),
                      Positioned(
                        bottom: -17,
                        right: -11,
                        child: IconButton(
                          onPressed: () async{
                            await service.getImageGallery();
                          },
                          icon: const Icon(Icons.camera_alt),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  CustomTextFormField(
                    obscureText: true,
                    icon: Icons.person,
                    controller: _model.name,
                    hintText: "Enter your name",
                    labelText: "Name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    obscureText: true,
                    icon: Icons.email,
                    controller: _model.email,
                    hintText: "Enter your Email",
                    labelText: "Email",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    onTap: () {
                      _model.showOrHiddenText();
                      setState(() {});
                    },
                    obscureText: _model.isShowText,
                    icon:
                        _model.isShowText ? Icons.visibility : Icons.visibility,
                    controller: _model.password,
                    hintText: "Enter your Password",
                    labelText: "Password",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    onTap: () {
                      _model.showOrHiddenText();
                      setState(() {});
                    },
                    obscureText: _model.isShowText,
                    icon:
                        _model.isShowText ? Icons.visibility : Icons.visibility,
                    controller: _model.confirmPassword,
                    hintText: "Enter your Password again",
                    labelText: "Password",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomButtonAuth(
                    onTap: () async {
                      await _model.signUp(context: context);
                    },
                    title: 'Next',
                    color: buttonLoginColor,
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
