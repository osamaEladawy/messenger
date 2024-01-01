
import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/viewmodel/regesterviewmodel.dart';
import '../widgets/shared/custom_mybutton.dart';
import '../widgets/shared/custom_textfield.dart';

class PageRegister extends StatefulWidget {
  final void Function()? onTap;
  const PageRegister({super.key, this.onTap});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  TextEditingController toName = TextEditingController();
  TextEditingController toEmail = TextEditingController();
  TextEditingController toPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RegisterViewModel viewModel = RegisterViewModel();
  @override
  void dispose() {
    toEmail.dispose();
    toName.dispose();
    toPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body:SafeArea(
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 25),
            child: ListView(
              shrinkWrap: true,
              children: [
                Form(
                  key: viewModel.formState,
                  child: Column(
                    children: [
                      const SizedBox(height: 50,),
                      Container(
                        decoration:const BoxDecoration(

                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: ()async{
                                await viewModel.uploadImage(context);
                                setState(() {

                                });
                              },
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundColor: Colors.blue,
                                backgroundImage:viewModel.handelUploadImage.file != null ? FileImage(File(viewModel.handelUploadImage.file!.path)) :viewModel.handelUploadImage.url != null ? viewModel.handelUploadImage.url!.isNotEmpty ?
                                NetworkImage("${viewModel.handelUploadImage.url}") as ImageProvider : null:null,
                                //view.whenViewImage(),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const Text("please Choose a image")
                          ],
                        ),
                      ),
                      const SizedBox(height: 40,),
                      Text(viewModel.text1,textAlign: TextAlign.center,style:const TextStyle(fontSize: 16),),
                      const SizedBox(height: 25,),
                      CustomTextField(
                        sizedField: viewModel.sizedTextField,
                        hintText: viewModel.hint1,
                        controller: toName,
                        obscureText: false,
                        labelText: viewModel.name,
                        icon:const Icon(Icons.person),
                      ),
                      const SizedBox(height: 10,),
                      CustomTextField(
                        sizedField: viewModel.sizedTextField,
                        hintText: viewModel.hint2,
                        controller: toEmail,
                        obscureText: false,
                        labelText: viewModel.email,
                        icon:const Icon(Icons.email),
                      ),
                      const SizedBox(height: 10,),
                      CustomTextField(
                        onPressed: (){
                          viewModel.changeStatte();
                          setState(() {

                          });
                        },
                        sizedField: viewModel.sizedTextField,
                        hintText: viewModel.hint3,
                        controller: toPassword,
                        obscureText: viewModel.hidenText,
                        labelText: viewModel.password,
                        icon:const Icon(Icons.lock),
                      ),
                      const SizedBox(height: 10,),
                      CustomTextField(
                        onPressed: (){
                          viewModel.changeStatte();
                          setState(() {

                          });
                        },
                        sizedField: viewModel.sizedTextField,
                        hintText: viewModel.hint4,
                        controller: confirmPassword,
                        obscureText: viewModel.hidenText,
                        labelText: viewModel.confirm,
                        icon:const Icon(Icons.lock),
                      ),
                      const SizedBox(height: 25,),
                      MyButton(
                        text: viewModel.sgin_up,
                        onTap:(){
                          viewModel.signUp(context: context, toPassword:toPassword.text, confirmPassword:confirmPassword.text, toName: toName.text, toEmail: toEmail.text,);
                          setState(() {

                          });
                        },
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(viewModel.ask),
                          const SizedBox(width: 10,),
                          GestureDetector(
                            onTap:widget.onTap,
                            child:  Text(viewModel.Sign_In,style:const TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
