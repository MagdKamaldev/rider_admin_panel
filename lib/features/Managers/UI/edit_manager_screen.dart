import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Managers/data/repos/managers_repo_impl.dart';
import 'package:tayar_admin_panel/features/Managers/logic/cubit/managers_cubit.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';

class EditManagerScreen extends StatefulWidget {
  final int managerId;
  const EditManagerScreen({super.key, required this.managerId,});

  @override
  EditManagerScreenState createState() => EditManagerScreenState();
}

class EditManagerScreenState extends State<EditManagerScreen> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (context) => ManagersCubit(getIt<ManagersRepoImpl>()),
        child: BlocConsumer<ManagersCubit, ManagersState>(
            listener: (context, state) {
          if (state is UpdateManagerSuccess) {
            navigateAndFinish(context, const HomeScreen());
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title:  Text("Edit Managers", style: TextStyles.headings),
            ),
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
                            "Edit Manager",
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
                                  return "Please enter the manager's name!";
                                }
                                return null;
                              },
                              label: "Manager Name",
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
                              type: TextInputType.name,
                              onSubmit: () {},
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter the manager's paasword!";
                                }
                                return null;
                              },
                              label: "Manager Password",
                              prefix: Icons.lock,
                              context: context,
                            ),
                          ),
                          SizedBox(height: size.height * 0.1),
                          if (state is! UpdateManagerLoading)
                            defaultButton(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ManagersCubit>().updateManager(
                                        context,
                                        _nameController.text,
                                        _passwordController.text,
                                        widget.managerId,
                                      );
                                }
                              },
                              context: context,
                              text: "Edit Manager",
                            ),
                          if (state is AddManagerLoadinState)
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
        }));
  }
}
