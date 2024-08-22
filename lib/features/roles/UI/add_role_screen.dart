import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/roles/data/repos/roles_repo_impl.dart';
import 'package:tayar_admin_panel/features/roles/logic/cubit/role_cubit.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class AddRole extends StatelessWidget {
  const AddRole({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          RoleCubit(getIt<RolesRepoImpl>())..getGroups(context),
      child: BlocBuilder<RoleCubit, RoleState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).addRole,
                style: TextStyles.headings,
              ),
              centerTitle: true,
              toolbarHeight: size.height * 0.2 > 120 ? 120 : size.height * 0.2,
              backgroundColor: AppColors.prussianBlue,
            ),
          );
        },
      ),
    );
  }
}
