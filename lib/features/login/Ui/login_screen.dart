// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/features/login/data/repos/login_repo_impl.dart';
import 'package:tayar_admin_panel/features/login/logic/cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => LoginCubit(getIt<LoginRepositoryImpelemntation>()),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            navigateAndFinish(context, const HomeScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * 0.2),
                          Text(
                            "Tayaar App",
                            style: TextStyles.normal,
                          ),
                          SizedBox(height: size.height * 0.1),
                          SizedBox(
                            width:
                                size.width * 0.8 < 700 ? size.width * 0.8 : 700,
                            child: defaultFormField(
                              controller: _nameController,
                              type: TextInputType.name,
                              onSubmit: () {},
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter a value!";
                                }
                                return null;
                              },
                              label: "Name",
                              prefix: Icons.person,
                              context: context,
                            ),
                          ),
                          SizedBox(height: size.height * 0.1),
                          SizedBox(
                            width:
                                size.width * 0.8 < 700 ? size.width * 0.8 : 700,
                            child: defaultFormField(
                              controller: _passwordController,
                              type: TextInputType.visiblePassword,
                              onSubmit: () {},
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter a value!";
                                }
                                return null;
                              },
                              label: "Password",
                              prefix: Icons.lock,
                              isPassword: true,
                              context: context,
                            ),
                          ),
                          SizedBox(height: size.height * 0.1),
                          if (state is! LoginLoadingState)
                            defaultButton(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().login(
                                      context,
                                      _nameController.text,
                                      _passwordController.text);
                                }
                              },
                              context: context,
                              text: "Login",
                            ),
                          if (state is LoginLoadingState)
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
