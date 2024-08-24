import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/roles/data/repos/roles_repo_impl.dart';
import 'package:tayar_admin_panel/features/roles/logic/cubit/role_cubit.dart';
import 'package:tayar_admin_panel/features/users/data/models/user_model.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class EditUser extends StatefulWidget {
  final UserModel user;

  const EditUser({super.key, required this.user});

  @override
  EditUserState createState() => EditUserState();
}

class EditUserState extends State<EditUser> {
  int? selectedRoleIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoleCubit(getIt<RolesRepoImpl>())..getRoles(context),
      child: BlocBuilder<RoleCubit, RoleState>(
        builder: (context, state) {
          Size size = MediaQuery.of(context).size;

          // Determine the number of columns based on screen width
          int crossAxisCount;
          if (size.width > 900) {
            crossAxisCount = 4;
          } else if (size.width > 600) {
            crossAxisCount = 3;
          } else {
            crossAxisCount = 2;
          }

          if (state is GetRoleSuccess && selectedRoleIndex == null) {
            // Find the index of the user's current roleId
            selectedRoleIndex = RoleCubit.get(context).roles.indexWhere(
              (role) => role.id == widget.user.roleId,
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).assignRole,
                style: TextStyles.headings,
              ),
              centerTitle: true,
              toolbarHeight: size.height * 0.2 > 120 ? 120 : size.height * 0.2,
              backgroundColor: AppColors.prussianBlue,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is GetRoleLoading)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 3,
                        ),
                        itemCount: RoleCubit.get(context).roles.length,
                        itemBuilder: (context, index) {
                          final role = RoleCubit.get(context).roles[index];
                          final isSelected = index == selectedRoleIndex;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedRoleIndex = index;
                              });
                            },
                            child: Card(
                              color: isSelected
                                  ? AppColors.prussianBlue
                                  : AppColors.ivory,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.02,
                                  ),
                                  child: Text(
                                    role.name!,
                                    style: TextStyles.headings.copyWith(
                                      color: isSelected
                                          ? AppColors.ivory
                                          : AppColors.prussianBlue,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 20),
                  defaultButton(
                    function: () {
                      if (selectedRoleIndex != null) {
                        RoleCubit.get(context).assignUserToRole(
                          context,
                          widget.user.id!,
                          RoleCubit.get(context)
                              .roles[selectedRoleIndex!]
                              .id!,
                        );
                      }
                    },
                    context: context,
                    text: S.of(context).assign,
                    width: size.width * 0.5 > 300 ? size.width * 0.5 : 300,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}