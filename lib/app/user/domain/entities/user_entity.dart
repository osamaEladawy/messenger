// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  late final String? uid;
  late final String? username;
  late final String? email;
  late final String? bio;
  late final String? imageUrl;
  late final bool? isOnline;
  late final dateWhenLogOut;
  late final bool? isPrivate;

    UserEntity({
    this.imageUrl,
    this.username,
    this.isOnline,
    this.bio,
    this.uid,
    this.email,
    this.dateWhenLogOut,
    this.isPrivate
});

  @override
  List<Object?> get props => [
        username,
        email,
        uid,
        bio,
        isOnline,
        imageUrl,
        isOnline,
        dateWhenLogOut, 
        isPrivate,
      ];
}
