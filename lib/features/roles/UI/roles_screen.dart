import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/roles/UI/add_role_screen.dart';
import 'package:tayar_admin_panel/features/roles/UI/edit_role.dart';
import 'package:tayar_admin_panel/features/roles/data/repos/roles_repo_impl.dart';
import 'package:tayar_admin_panel/features/roles/logic/cubit/role_cubit.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class RolesAndPermissionsScreen extends StatelessWidget {
  const RolesAndPermissionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoleCubit(getIt<RolesRepoImpl>())..getRoles(context),
      child: BlocBuilder<RoleCubit, RoleState>(
        builder: (context, state) {
          Size size = MediaQuery.of(context).size;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                defaultButton(
                    function: () {
                      navigateTo(context, const AddRole());
                    },
                    text: S.of(context).addRole,
                    context: context,
                    width: size.width * 0.1 > 200 ? 200 : size.width * 0.1),
                const SizedBox(height: 16.0),
                if (state is! GetRoleLoading)
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 4 : 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 3, // Adjust for role name fit
                      ),
                      itemCount: RoleCubit.get(context).roles.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: AppColors.ivory,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(
                                  RoleCubit.get(context).roles[index].name!,
                                  style: TextStyles.headings.copyWith(
                                    color: AppColors.prussianBlue,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: IconButton(
                                    onPressed: () {
                                       navigateTo(context, EditRole(role: RoleCubit.get(context).roles[index],));
                                    },
                                    icon: const Icon(Icons.edit)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                else
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

