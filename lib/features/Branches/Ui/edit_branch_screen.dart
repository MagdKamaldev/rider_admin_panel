
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

class UpdateBranchScreen extends StatefulWidget {
  final int branchId;
  final String branchName;
  final String branchAdress;
  final int branchHubId;
  final int branchFranchiseId;
  const UpdateBranchScreen({super.key, required this.branchId, required this.branchName, required this.branchAdress, required this.branchHubId, required this.branchFranchiseId});

  @override
  UpdateBranchScreenState createState() => UpdateBranchScreenState();
}



class UpdateBranchScreenState extends State<UpdateBranchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Hub? _selectedHub;
  FranchiseModel? _selectedFranchise;
  TextEditingController nameController = TextEditingController();
  TextEditingController adressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.branchName;
    adressController.text = widget.branchAdress;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) =>
          BranchCubit(getIt<BranchRepoImpl>())..getBranchData(context),
      child: BlocConsumer<BranchCubit, BranchState>(
        listener: (context, state) {
          if (state is UpdateBranchSuccess) {
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
                title:  Text("Edit Branch",style: TextStyles.headings),
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
                            if (state is! UpdateBranchLoading)
                              defaultButton(
                                width: size.width * 0.8 < 700
                                    ? size.width * 0.8
                                    : 700,
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<BranchCubit>().updateBranch(
                                          context,
                                          nameController.text,
                                          adressController.text,
                                          _selectedHub!.id!,
                                          _selectedFranchise!.id!,
                                          widget.branchId,
                                        );
                                  }
                                },
                                context: context,
                                text: "Edit Branch",
                              ),
                            if (state is UpdateBranchLoading)
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
