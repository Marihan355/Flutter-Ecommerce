import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/cubit/auth_state.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/home/presentation/pages/product_page_wrapper.dart';

class AuthCheckPage extends StatelessWidget {
  const AuthCheckPage({super.key}); //this widget never changes

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state; //(watch) listens to Authcubit and rebuilds the widget whenver the auth state changes

    if (state is AuthSuccess) {
      return const ProductsPageWrapper(); //if success, give productPageWrapper, it not, then login screen
    }

    return LoginScreen();
  }
}