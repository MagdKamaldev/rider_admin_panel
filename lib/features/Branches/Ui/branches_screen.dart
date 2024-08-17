import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Branches/Ui/add_branch_screen.dart';
import 'package:tayar_admin_panel/features/Branches/Ui/branch_table.dart';
import 'package:tayar_admin_panel/features/Branches/data/repos/branch_repo_impl.dart';
import 'package:tayar_admin_panel/features/Branches/logic/cubit/branch_cubit.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final scrollController = ScrollController();
    return BlocProvider(
      create: (context) =>
          BranchCubit(getIt<BranchRepoImpl>())..fetchBranches(context),
      child: BlocBuilder<BranchCubit, BranchState>(
        builder: (context, state) {
          if (state is GetBranchDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (BranchCubit.get(context).branches.isEmpty) {
            return SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                  ),
                  Text(
                    "No Branches Yet !",
                    style: TextStyles.headings
                        .copyWith(color: AppColors.prussianBlue),
                  ),
                  SizedBox(
                    height: size.height * 0.35,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: defaultButton(
                        function: () {
                          navigateTo(context, const AddBranchScreen());
                        },
                        context: context,
                        text: "Add Branch",
                        width: size.width * 0.8 < 500 ? size.width * 0.8 : 500),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                     children: [ 
                      Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defaultButton(
                          function: () {
                            navigateTo(context, const AddBranchScreen());
                          },
                          context: context,
                          text: "Add Branch",
                          width: size.width * 0.8 < 200 ? size.width * 0.8 : 200),
                                       ),
                     ],
                   ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Center(
                        child: Scrollbar(
                          controller: scrollController,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width,
                              ),
                              child: const BranchTable()
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
