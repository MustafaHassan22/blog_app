import 'package:blogapp/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blogapp/core/theme/theme.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:blogapp/features/auth/presentation/pages/login_page.dart';
import 'package:blogapp/features/blog/presentation/pages/blog_page.dart';
import 'package:blogapp/init_dependinces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      //auth bloc
      BlocProvider(
        create: (_) => serviceLocator<AuthBlocBloc>(),
      ),

      //auth cubit
      // BlocProvider(
      //   create: (_) => serviceLocator<AuthCubitCubit>(),
      // ),
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Check if the user is logged in when the app starts
    // context.read<AuthCubitCubit>().checkCurrentUser();
    context.read<AuthBlocBloc>().add(AuthLoggedInEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.dartThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const BlogPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
