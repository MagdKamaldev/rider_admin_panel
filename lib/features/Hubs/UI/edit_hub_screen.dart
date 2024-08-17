import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Hubs/data/repos/hubs_repo_impl.dart';
import 'package:tayar_admin_panel/features/Hubs/logic/cubit/hub_cubit.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/manager_model.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';

class EditHubScreen extends StatefulWidget {
  final int id;
  final String name;
  final int managerId;
  const EditHubScreen(
      {super.key,
      required this.id,
      required this.name,
      required this.managerId});

  @override
  EditHubScreenState createState() => EditHubScreenState();
}

class EditHubScreenState extends State<EditHubScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  ManagerModel? _selectedManager;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameController.text = widget.name;
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
        create: (context) =>
            HubCubit(getIt<HubsRepoImpl>())..fetchManagers(context),
        child: BlocConsumer<HubCubit, HubState>(listener: (context, state) {
          if (state is UpdateHubSuccess) {
            navigateAndFinish(context, const HomeScreen());
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Edit Hubs", style: TextStyles.headings),
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
                            "Edit Hub",
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
                                  return "Please enter the Hub's name!";
                                }
                                return null;
                              },
                              label: "Hub Name",
                              prefix: Icons.person,
                              context: context,
                            ),
                          ),
                          SizedBox(height: size.height * 0.1),
                          SizedBox(
                            width:
                                size.width * 0.8 < 700 ? size.width * 0.8 : 700,
                            child: DropdownButtonFormField<ManagerModel>(
                              value: _selectedManager,
                              hint: const Text("Select Hub Manager"),
                              items: context
                                  .read<HubCubit>()
                                  .managers
                                  .map((manager) {
                                return DropdownMenuItem<ManagerModel>(
                                  value: manager,
                                  child: Text(manager.name!),
                                );
                              }).toList(),
                              onChanged: (ManagerModel? value) {
                                setState(() {
                                  _selectedManager = value;
                                });
                              },
                              validator: (ManagerModel? value) {
                                if (value == null) {
                                  return "Please select a Hub Manager !";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: "Branch Hub",
                                prefixIcon: Icon(Icons.work),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.1),
                          if (state is! UpdateHubLoading)
                            defaultButton(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<HubCubit>().updateHub(
                                        context,
                                        _nameController.text,
                                        _selectedManager!.id!,
                                        widget.id,
                                      );
                                }
                              },
                              context: context,
                              text: "Edit Hub",
                            ),
                          if (state is UpdateHubLoading)
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
