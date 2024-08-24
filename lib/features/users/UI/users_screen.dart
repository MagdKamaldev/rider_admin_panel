import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/users/UI/edit_user.dart';
import 'package:tayar_admin_panel/features/users/data/repos/users_repo_impl.dart'; // Update this path based on your project structure
import 'package:tayar_admin_panel/features/users/logic/cubit/users_cubit.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(getIt<UsersRepoImpl>())..getUsers(context),
      child: BlocBuilder<UsersCubit, UsersState>(
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
                    // Navigate to AddUser screen if applicable
                  },
                  text: S.of(context).addUser, // Update localization key
                  context: context,
                  width: size.width * 0.2 > 200 ? 200 : size.width * 0.2,
                ),
                const SizedBox(height: 16.0),
                if (state is! GetUsersLoading)
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 3, // Adjust for user name fit
                      ),
                      itemCount: UsersCubit.get(context).users.length,
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
                                    UsersCubit.get(context).users[index].username!,
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
                                      EditUser(
                                        user:
                                            UsersCubit.get(context).users[index],
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