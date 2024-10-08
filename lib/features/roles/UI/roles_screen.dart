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

          // Determine the number of columns based on screen width
          int crossAxisCount;
          if (size.width > 900) {
            crossAxisCount = 4;
          } else if (size.width > 600) {
            crossAxisCount = 3;
          } else {
            crossAxisCount = 2;
          }

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
                  width: size.width * 0.2 > 200 ? 200 : size.width * 0.2,
                ),
                const SizedBox(height: 16.0),
                if (state is! GetRoleLoading)
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    RoleCubit.get(context).roles[index].name!,
                                    style: TextStyles.headings.copyWith(
                                      color: AppColors.prussianBlue,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    navigateTo(
                                      context,
                                      EditRole(
                                        role:
                                            RoleCubit.get(context).roles[index],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                  iconSize: size.width * 0.03 > 20
                                      ? 30
                                      : size.width * 0.03,
                                ),
                              ],
                            ),
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
