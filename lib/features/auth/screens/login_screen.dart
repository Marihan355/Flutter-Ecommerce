import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marihan_store/core/utils/app_validation.dart';
import 'package:marihan_store/core/utils/context_extension.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../../../core/utils/responsiveness.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pass = TextEditingController();
  final ValueNotifier<bool> _obscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final w = screenWidth(context);  //responsive width
    final h = screenHeight(context); //responsive height

    return Scaffold(
      backgroundColor: const Color(0xFFEDE3FF),
      body: SafeArea(   
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(w * 0.05), 
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                    context, "/products", (route) => false,
                  );
                } else if (state is AuthFailure) {
                  context.showSnackBar(state.message);
                }
              },
              builder: (context, state) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.03), 
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(w * 0.05), 
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: w * 0.06, 
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: h * 0.02),

                          /// EMAIL FIELD
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(w * 0.03),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: email,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                labelText: "Email",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                              ),
                              validator: AppValidation.validateEmail,
                            ),
                          ),
                          SizedBox(height: h * 0.015),

                          /// PASSWORD FIELD
                          ValueListenableBuilder(
                            valueListenable: _obscure,
                            builder: (context, value, _) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(w * 0.03),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: pass,
                                  obscureText: value,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    suffixIcon: IconButton(
                                      icon: Icon(value
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () => _obscure.value = !value,
                                    ),
                                  ),
                                  validator: AppValidation.validatePassword,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: h * 0.025),

                          /// LOGIN BUTTON
                          state is AuthLoading
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().login(
                                          email.text.trim(),
                                          pass.text.trim(),
                                        );
                                      }
                                    },
                                    child: const Text("Login"),
                                  ),
                                ),

                          SizedBox(height: h * 0.01),

                          /// REGISTER LINK
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, "/register");
                            },
                            child: const Text("Create account"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}