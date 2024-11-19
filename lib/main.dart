import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app/core/class/my_bloc_observer.dart';
import 'package:messenger_app/core/storage/pref_services.dart';
import 'package:messenger_app/features/calls/presentation/manager/agora/agora_cubit.dart';
import 'package:messenger_app/features/calls/presentation/manager/call/call_cubit.dart';
import 'package:messenger_app/features/calls/presentation/manager/my_call/my_call_history_cubit.dart';
import 'package:messenger_app/features/chat/presentation/manager/chat/chat_cubit.dart';
import 'package:messenger_app/features/chat/presentation/manager/message/message_cubit.dart';
import 'package:messenger_app/features/home_tap/cubit/home_tab_cubit.dart';
import 'package:messenger_app/features/status/presentation/manager/get_my_status/get_my_status_cubit.dart';
import 'package:messenger_app/features/status/presentation/manager/status/status_cubit.dart';
import 'package:messenger_app/features/user/presentation/manager/auth/auth_cubit.dart';
import 'package:messenger_app/features/user/presentation/manager/cerdential/credential_cubit.dart';
import 'package:messenger_app/features/user/presentation/manager/get_single_user/get_single_user_cubit.dart';
import 'package:messenger_app/features/user/presentation/manager/user/user_cubit.dart';
import 'package:messenger_app/core/class/handel_image.dart';
import 'package:messenger_app/core/providers/auth_service.dart';
import 'package:messenger_app/core/providers/users_providers.dart';
import 'package:messenger_app/firebase_options.dart';
import 'package:messenger_app/main_injection_container.dart';
import 'package:messenger_app/core/providers/storage_provider.dart';
import 'package:messenger_app/my_app.dart';
import 'package:provider/provider.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await PrefServices.init();
  await init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => HandleImage()),
        ChangeNotifierProvider(create: (context) => UsersProviders()),
        ChangeNotifierProvider(
            create: (context) => StorageProviderRemoteDataSource()),

        //*Bloc
        BlocProvider(create: (context) => sl<AuthCubit>()..appStarted()),
        BlocProvider(create: (context) => sl<CredentialCubit>()),
        BlocProvider(create: (context) => sl<GetSingleUserCubit>()),
        BlocProvider(create: (context) => sl<UserCubit>()),
        BlocProvider(create: (context) => sl<ChatCubit>()),
        BlocProvider(create: (context) => sl<MessageCubit>()),
        BlocProvider(create: (context) => sl<StatusCubit>()),
        BlocProvider(create: (context) => sl<GetMyStatusCubit>()),
        BlocProvider(create: (context) => sl<CallCubit>()),
        BlocProvider(create: (context) => sl<MyCallHistoryCubit>()),
        BlocProvider(create: (context) => sl<AgoraCubit>()),
        BlocProvider(create: (context) => sl<HomeTabCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}
