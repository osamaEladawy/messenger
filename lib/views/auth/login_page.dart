
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messenger/views/widgets/shared/custom_textfield.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../data/viewmodel/loginpage_viewmodel.dart';
import '../widgets/shared/custom_mybutton.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key, this.onTap});
  final void Function()? onTap;

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  TextEditingController toEmail = TextEditingController();
  TextEditingController toPassword = TextEditingController();

  final RoundedLoadingButtonController buttonController =
  RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController =
  RoundedLoadingButtonController();
  Timer? _timer;
  bool val = false;
  var view = LoginViewModel();

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Icon(
                Icons.message,
                size: 90,
                color: Colors.grey[800],
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                view.text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                view.text2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600]),
              ),
              Switch(
                activeColor: Colors.lightBlue,
                activeTrackColor: Colors.grey.shade300,
                inactiveThumbColor: Colors.lightBlue,
                value: val,
                onChanged: (value) {
                  setState(() {
                    val = value;
                  });
                },
              ),
              val? Form(
                key: view.formState,
                child: Column(
                  children: [
                    Text(
                      view.text3,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.lightBlue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      sizedField: view.sizeText,
                      hintText: view.hint1,
                      controller: toEmail,
                      obscureText: false,
                      labelText: view.label,
                      icon:const Icon(Icons.email),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      sizedField: view.sizeText,
                      hintText: view.password,
                      controller: toPassword,
                      obscureText: true,
                      labelText: view.pass,
                      icon:const Icon(Icons.lock),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyButton(
                      text: view.button,
                      onTap: () {},
                    ),
                  ],
                ),
              )
                  : Form(
                key: view.formState,
                child: Column(
                  children: [
                    Text(
                      view.textEmail,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.lightBlue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      sizedField: view.sizeText,
                      icon:const Icon(Icons.email),
                      hintText: view.hintEmail,
                      controller: toEmail,
                      obscureText: false,
                      labelText: view.labelEmail,
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    CustomTextField(
                      sizedField: view.sizeText,
                      onPressed: (){
                        view.changeState();
                        setState(() {

                        });
                      },
                      hintText: view.password,
                      controller: toPassword,
                      obscureText: view.hiddenText,
                      labelText: view.pass,
                      icon:const Icon(Icons.lock),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyButton(
                      text: view.button,
                      onTap: () {
                        view.signIN(
                            context, toEmail.text, toPassword.text);
                        setState(() {

                        });
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    view.forgetPassword(context,toEmail.text );
                  },
                  child:  Text(
                    view.forgetMyPassword,
                    style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RoundedLoadingButton(
                controller: buttonController,
                successColor: Colors.red,
                color: Colors.red,
                height: 40,
                width: MediaQuery.of(context).size.width * 0.80,
                borderRadius: 25,
                elevation: 0,
                onPressed: () {
                  // _handlegoogleSignIn();
                  view.handlegoogleSignIn(context, buttonController);
                },
                child:  Wrap(
                  children: [
                    const Icon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      view.sign_google,
                      textAlign: TextAlign.center,
                      style:const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              RoundedLoadingButton(
                controller: facebookController,
                successColor: Colors.blue,
                color: Colors.blue,
                height: 40,
                width: MediaQuery.of(context).size.width * 0.80,
                borderRadius: 25,
                elevation: 0,
                onPressed: () {
                  // _handleFacebookSignIn();
                  view.handleFacebookSignIn(context, facebookController);
                },
                child:  Wrap(
                  children: [
                    const Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      view.sgin_face,
                      textAlign: TextAlign.center,
                      style:const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    view.not_A_Member,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      view.register,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

