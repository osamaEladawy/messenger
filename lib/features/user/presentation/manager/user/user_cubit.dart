import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app/my_app.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/use_cases/user/get_all_users_usecases.dart';
import '../../../domain/use_cases/user/update_user_usecases.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsersUseCases getAllUsersUseCases;
  final UpdateUserUseCases updateUserUseCases;

  UserCubit({
    required this.updateUserUseCases,
    required this.getAllUsersUseCases,
  }) : super(UserInitial());

  static final UserCubit _userCubit =
      BlocProvider.of(navigatorKey.currentContext!);
  static UserCubit get instance => _userCubit;

  Future<void> getAllUsers() async {
    emit(UserLoading());
    final streamResponse = await getAllUsersUseCases.call();
    streamResponse.listen((users) {
      emit(UserLoaded(users: users));
    });
  }

  Future<void> updateUsers({required UserEntity userEntity}) async {
    try {
      await updateUserUseCases.call(userEntity);
    } catch (e) {
      emit(UserFailure());
    }
  }
}
