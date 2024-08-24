import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/roles/UI/permission_group_card.dart';
import 'package:tayar_admin_panel/features/roles/data/models/permission_group_model/permission.dart';
import 'package:tayar_admin_panel/features/roles/data/models/permission_group_model/permission_group_model.dart';
import 'package:tayar_admin_panel/features/roles/data/repos/roles_repo_impl.dart';
import 'package:tayar_admin_panel/features/roles/logic/cubit/role_cubit.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class AddRole extends StatefulWidget {
  const AddRole({super.key});

  @override
  AddRoleState createState() => AddRoleState();
}

class AddRoleState extends State<AddRole> {
  TextEditingController nameController = TextEditingController();
  Size? size;
  Map<int, bool> selectedPermissions = {};

  @override
  void initState() {
    super.initState();
  }

  void updateSelection(Permission permission, bool isSelected) {
    setState(() {
      selectedPermissions[permission.id!] = isSelected;
    });
  }

  List<int> getSelectedPermissionIds() {
    return selectedPermissions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  void onAddRoleButtonPressed(BuildContext context) {
    List<int> ids = getSelectedPermissionIds();
    RoleCubit.get(context).addRole(context, nameController.text, ids);
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
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  S.of(context).addRole,
                  style: TextStyles.headings,
                ),
                centerTitle: true,
                toolbarHeight:
                    size!.height * 0.2 > 120 ? 120 : size!.height * 0.2,
                backgroundColor: AppColors.prussianBlue,
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: SizedBox(
                      width: size!.width * 0.5 > 300 ? size!.width * 0.5 : 300,
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
                          initialPermissionStates: const {},
                          group: group,
                          onSelectionChanged: updateSelection,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: size!.width * 0.5 > 300 ? size!.width * 0.5 : 300,
                    child: defaultButton(
                      function: () => onAddRoleButtonPressed(context),
                      context: context,
                      text: S.of(context).addRole,
                    ),
                  ),
                  SizedBox(height: size!.height * 0.05),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
