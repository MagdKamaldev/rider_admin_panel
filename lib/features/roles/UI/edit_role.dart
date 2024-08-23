import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/roles/UI/permission_group_card.dart';
import 'package:tayar_admin_panel/features/roles/data/models/permission_group_model/permission.dart';
import 'package:tayar_admin_panel/features/roles/data/models/permission_group_model/permission_group_model.dart';
import 'package:tayar_admin_panel/features/roles/data/models/role_model/role_model.dart';
import 'package:tayar_admin_panel/features/roles/data/repos/roles_repo_impl.dart';
import 'package:tayar_admin_panel/features/roles/logic/cubit/role_cubit.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class EditRole extends StatefulWidget {
  final RoleModel role;
  const EditRole({super.key, required this.role});

  @override
  EditRoleState createState() => EditRoleState();
}

class EditRoleState extends State<EditRole> {
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Size? size;
  Map<int, bool> selectedPermissions = {}; // Track individual permissions

  @override
  void initState() {
    super.initState();
    nameController.text = widget.role.name!;
    _initializeSelectedPermissions();
  }

  void _initializeSelectedPermissions() {
    for (var permission in widget.role.permissions ?? []) {
      selectedPermissions[permission.id!] = true;
    }
  }

  void updateSelection(Permission permission, bool isSelected) {
    setState(() {
      selectedPermissions[permission.id!] = isSelected;
    });
  }

  List<int> getSelectedPermissionIds() {
    return selectedPermissions.entries
        .where((entry) => entry.value) // Filter only selected permissions
        .map((entry) => entry.key)
        .toList();
  }

  void onEditRoleButtonPressed(String name, RoleCubit cubit) {
    List<int> ids = getSelectedPermissionIds();
    cubit.editRole(context, widget.role.id!, name, ids); // Ensure editRole method is defined
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          RoleCubit(getIt<RolesRepoImpl>())..getGroups(context),
      child: BlocBuilder<RoleCubit, RoleState>(
        builder: (context, state) {
          if (state is GetPermissionGroupLoading) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (state is GetPermissionGroupSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  S.of(context).editRole,
                  style: TextStyles.headings,
                ),
                centerTitle: true,
                toolbarHeight:
                    size!.height * 0.2 > 120 ? 120 : size!.height * 0.2,
                backgroundColor: AppColors.prussianBlue,
              ),
              body: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: SizedBox(
                        width:
                            size!.width * 0.5 > 300 ? size!.width * 0.5 : 300,
                        child: defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            onSubmit: () {},
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return S.of(context).emptyValidation;
                              }
                              return null;
                            },
                            label: S.of(context).roleName,
                            prefix: Icons.text_fields_sharp,
                            context: context),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20.0),
                        itemCount: RoleCubit.get(context).groups.length,
                        itemBuilder: (context, index) {
                          PermissionGroupModel group =
                              RoleCubit.get(context).groups[index];
                          return PermissionGroupCard(
                            group: group,
                            onSelectionChanged: updateSelection,
                            initialPermissionStates: selectedPermissions,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: size!.width * 0.5 > 300 ? size!.width * 0.5 : 300,
                      child: defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            onEditRoleButtonPressed(
                                nameController.text, RoleCubit.get(context));
                          }
                        },
                        text: S.of(context).editRole,
                        context: context,
                        color: AppColors.prussianBlue,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(child: Text("Error loading permission groups")),
            );
          }
        },
      ),
    );
  }
}