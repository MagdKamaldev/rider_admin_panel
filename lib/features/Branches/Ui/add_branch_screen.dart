// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/franchise_model/franchise_model.dart';
import 'package:tayar_admin_panel/features/Branches/data/repos/branch_repo_impl.dart';
import 'package:tayar_admin_panel/features/Branches/logic/cubit/branch_cubit.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';


//make an add rider screen that takes a hub which is selected and name and national id and mobile number and make it like :
class AddBranchScreen extends StatefulWidget {
  const AddBranchScreen({super.key});

  @override
  _AddBranchScreenState createState() => _AddBranchScreenState();
}

class _AddBranchScreenState extends State<AddBranchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Hub? _selectedHub;
  FranchiseModel? _selectedFranchise;
  TextEditingController nameController = TextEditingController();
  TextEditingController adressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) =>
          BranchCubit(getIt<BranchRepoImpl>())..getBranchData(context),
      child: BlocConsumer<BranchCubit, BranchState>(
        listener: (context, state) {
          if (state is AddBranchSuccessState) {
            navigateAndFinish(context, const HomeScreen());
          }
        },
        builder: (context, state) {
          if (state is GetBranchDataLoading) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else {
            return Scaffold(
              appBar: AppBar(
                title:  Text("Add Branch",style: TextStyles.headings),
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
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: defaultFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                onSubmit: () {},
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Please enter the Branch name!";
                                  }
                                  return null;
                                },
                                label: "Branch Name",
                                prefix: Icons.store,
                                context: context,
                              ),
                            ),
                            SizedBox(height: size.height * 0.1),
                            SizedBox(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: defaultFormField(
                                controller: adressController,
                                type: TextInputType.name,
                                onSubmit: () {},
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Please enter the Branch address!";
                                  }
                                  return null;
                                },
                                label: "Branch Address",
                                prefix: Icons.location_on,
                                context: context,
                              ),
                            ),
                            SizedBox(height: size.height * 0.1),
                            SizedBox(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: DropdownButtonFormField<Hub>(
                                value: _selectedHub,
                                hint: const Text("Select Branch Hub"),
                                items:
                                    context.read<BranchCubit>().hubs.map((hub) {
                                  return DropdownMenuItem<Hub>(
                                    value: hub,
                                    child: Text(hub.name!),
                                  );
                                }).toList(),
                                onChanged: (Hub? value) {
                                  setState(() {
                                    _selectedHub = value;
                                  });
                                },
                                validator: (Hub? value) {
                                  if (value == null) {
                                    return "Please select a branch hub!";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: "Branch Hub",
                                  prefixIcon: Icon(Icons.business),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.1),
                            SizedBox(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: DropdownButtonFormField<FranchiseModel>(
                                value: _selectedFranchise,
                                hint: const Text("Select Branch Franchise"),
                                items: context
                                    .read<BranchCubit>()
                                    .franchises
                                    .map((franchise) {
                                  return DropdownMenuItem<FranchiseModel>(
                                    value: franchise,
                                    child: Text(franchise.name!),
                                  );
                                }).toList(),
                                onChanged: (FranchiseModel? value) {
                                  setState(() {
                                    _selectedFranchise = value;
                                  });
                                },
                                validator: (FranchiseModel? value) {
                                  if (value == null) {
                                    return "Please select a branch franchise!";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: "Branch Franchise",
                                  prefixIcon: Icon(Icons.store),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.1),
                            if (state is! AddBranchLoadingState)
                              defaultButton(
                                width: size.width * 0.8 < 700
                                    ? size.width * 0.8
                                    : 700,
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<BranchCubit>().addBranch(
                                          context,
                                          nameController.text,
                                          adressController.text,
                                          _selectedHub!.id!,
                                          _selectedFranchise!.id!,
                                        );
                                  }
                                },
                                context: context,
                                text: "Add Branch",
                              ),
                            if (state is AddBranchLoadingState)
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
          }
        },
      ),
    );
  }
}
