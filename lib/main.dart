import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_therapy/common/screens/splash_screen.dart';
import 'package:my_therapy/common/theme/app_theme.dart';

import 'common/helpers/keyboard_dismiss_observer.dart';
import 'common/services/secure_storage_service.dart';
import 'features/admin/admin_cubit.dart';
import 'features/admin/admin_remote_data_source_impl.dart';
import 'features/admin/admin_repository_impl.dart';
import 'features/auth/controllers/auth_cubit.dart';
import 'features/auth/services/auth_remote_data_source_impl.dart';
import 'features/auth/services/auth_repository_impl.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(
            repository: AuthRepositoryImpl(
              remoteDataSource: AuthRemoteDataSourceImpl(),
            ),
            storage: SecureStorageService(),
          ),
        ),
        BlocProvider(
          create: (_) => AdminCubit(
            AdminRepositoryImpl(
              AdminRemoteDataSourceImpl(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: AppTheme.lightTheme,
        navigatorObservers: [
          KeyboardDismissObserver(),
          // ZegoUIKitPrebuiltCallInvitationService().navigatorObserver,
        ],
        home: const SplashScreen(), 
      ),
    );
  }
}