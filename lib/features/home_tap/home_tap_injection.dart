import 'package:messenger_app/features/home_tap/cubit/home_tab_cubit.dart';
import 'package:messenger_app/main_injection_container.dart';

Future<void> homeTapInjection() async {
  sl.registerFactory<HomeTabCubit>(() => HomeTabCubit());
}
