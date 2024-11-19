// ignore_for_file: invalid_use_of_visible_for_testing_member, unused_field, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger_app/core/functions/extinctions.dart';
import 'package:messenger_app/features/user/presentation/manager/user/user_cubit.dart';
import 'package:messenger_app/features/user/presentation/widgets/editprofile.dart/profilritem.dart';
import 'package:messenger_app/features/user/presentation/widgets/editprofile.dart/savedateforuser.dart';
import 'package:messenger_app/features/user/presentation/widgets/editprofile.dart/settingitemwidget.dart';
import 'package:messenger_app/core/const/app_const.dart';
import 'package:messenger_app/core/const/page_const.dart';
import 'package:messenger_app/core/shared/widgets/profile_widget.dart';
import 'package:messenger_app/core/shared/widgets/stackforimageuser.dart';
import 'package:messenger_app/core/providers/storage_provider.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/user_entity.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity currentUser;

  const EditProfilePage({super.key, required this.currentUser});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  bool _isProfileUpdating = false;
  File? _image;

  Future _selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  void initState() {
    _usernameController =
        TextEditingController(text: widget.currentUser.username);
    _bioController = TextEditingController(text: widget.currentUser.bio);
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ImageForUsers(
                onTap: _selectImage,
                child: profileWidget(
                    imageUrl: widget.currentUser.imageUrl, image: _image),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ProfileItem(
                controller: _usernameController,
                title: "Name",
                description: "Enter username",
                icon: Icons.person,
                onTap: () {}),
            ProfileItem(
                controller: _bioController,
                title: "Bio",
                description: "",
                icon: Icons.info_outline,
                onTap: () {}),
            SettingsItemWidget(
                title: "Email",
                description: "${widget.currentUser.email}",
                icon: Icons.email,
                onTap: () {}),
            const SizedBox(height: 40),
            SaveDataForUser(
              onTap: submitProfileInfo,
              isProfileUpdating: _isProfileUpdating,
            ),
          ],
        ),
      ),
    );
  }

  void submitProfileInfo() {
    if (_image != null) {
      var service =
          Provider.of<StorageProviderRemoteDataSource>(context, listen: false);
      service
          .uploadProfileImage(
        userId: "${widget.currentUser.uid}",
        file: _image!,
        onComplete: (onProfileUpdateComplete) {
          setState(() {
            _isProfileUpdating = onProfileUpdateComplete;
          });
        },
      )
          .then((profileImageUrl) {
        _profileInfo(profileUrl: profileImageUrl);
        Future.delayed(const Duration(milliseconds: 500));
        context.pushReplacementNamed(PageConst.profilePage,
            arguments: widget.currentUser.uid);
      });
    } else {
      _profileInfo(profileUrl: widget.currentUser.imageUrl);
    }
  }

  void _profileInfo({String? profileUrl}) {
    if (_usernameController.text.isNotEmpty && _bioController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context)
          .updateUsers(
              userEntity: UserEntity(
        uid: widget.currentUser.uid,
        email: widget.currentUser.email,
        isOnline: widget.currentUser.isOnline,
        isPrivate: widget.currentUser.isPrivate,
        dateWhenLogOut: widget.currentUser.dateWhenLogOut,
        username: _usernameController.text,
        bio: _bioController.text,
        imageUrl: profileUrl,
      ))
          .then((value) {
        toast("Profile updated");
      });
    }
  }
}
