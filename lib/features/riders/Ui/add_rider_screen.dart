// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/features/riders/data/repos/riders_repo_impl.dart';
import 'package:tayar_admin_panel/features/riders/logic/cubit/rider_cubit.dart';

//make an add rider screen that takes a hub which is selected and name and national id and mobile number and make it like :
class AddRiderScreen extends StatefulWidget {
  const AddRiderScreen({super.key});

  @override
  AddRiderScreenState createState() => AddRiderScreenState();
}

class AddRiderScreenState extends State<AddRiderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => RiderCubit(getIt<RiderRepoImpl>()),
      child: BlocConsumer<RiderCubit, RiderState>(listener: (context, state) {
        if (state is AddRiderSuccess) {
          navigateAndFinish(context, const HomeScreen());
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add Rider", style: TextStyles.headings),
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
                        SizedBox(height: size.height * 0.1),
                        SizedBox(
                          width:
                              size.width * 0.8 < 700 ? size.width * 0.8 : 700,
                          child: defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            onSubmit: () {},
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter the Rider name!";
                              }
                              return null;
                            },
                            label: "Rider Name",
                            prefix: Icons.store,
                            context: context,
                          ),
                        ),
                        SizedBox(height: size.height * 0.1),
                        SizedBox(
                          width:
                              size.width * 0.8 < 700 ? size.width * 0.8 : 700,
                          child: defaultFormField(
                            controller: nationalIdController,
                            type: TextInputType.name,
                            onSubmit: () {},
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter the Rider National Id!";
                              }
                              return null;
                            },
                            label: "Rider National ID",
                            prefix: Icons.location_on,
                            context: context,
                          ),
                        ),
                        SizedBox(height: size.height * 0.1),
                        SizedBox(
                          width:
                              size.width * 0.8 < 700 ? size.width * 0.8 : 700,
                          child: defaultFormField(
                            controller: mobileNumberController,
                            type: TextInputType.name,
                            onSubmit: () {},
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter the Rider Phone Number";
                              }
                              return null;
                            },
                            label: "Rider Phone Number",
                            prefix: Icons.location_on,
                            context: context,
                          ),
                        ),
                        SizedBox(height: size.height * 0.1),
                        SizedBox(
                          width:
                              size.width * 0.8 < 700 ? size.width * 0.8 : 700,
                          child: defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            onSubmit: () {},
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter the Rider Password";
                              }
                              return null;
                            },
                            label: "Rider Password",
                            prefix: Icons.location_on,
                            context: context,
                          ),
                        ),
                        SizedBox(height: size.height * 0.1),
                        if (state is! AddRiderLoading)
                          defaultButton(
                            width:
                                size.width * 0.8 < 700 ? size.width * 0.8 : 700,
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<RiderCubit>().addRider(
                                      nameController.text,
                                      nationalIdController.text,
                                      mobileNumberController.text,
                                      passwordController.text,
                                    );
                              }
                            },
                            context: context,
                            text: "Add Rider",
                          ),
                        if (state is AddRiderLoading)
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
      }),
    );
  }
}
