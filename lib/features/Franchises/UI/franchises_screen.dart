// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Franchises/UI/add_franchise_screen.dart';
import 'package:tayar_admin_panel/features/Franchises/UI/franchise_table.dart';
import 'package:tayar_admin_panel/features/Franchises/data/repos/franchise_repo_impl.dart';
import 'package:tayar_admin_panel/features/Franchises/logic/cubit/franchise_cubit.dart';
import 'package:tayar_admin_panel/generated/l10n.dart'; // Import your localization file

class FranchiseScreen extends StatelessWidget {
  const FranchiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final scrollController = ScrollController();
    return BlocProvider(
      create: (context) =>
          FranchiseCubit(getIt<FranchiseRepoImpl>())..fetchFranchises(context),
      child: BlocBuilder<FranchiseCubit, FranchiseState>(
        builder: (context, state) {
          if (state is GetFranchiseDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (FranchiseCubit.get(context).franchises.isEmpty) {
            return SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                  ),
                  Text(
                    S.of(context).noBranchesYet, // Use localization
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
                          navigateTo(context, const AddFranchiseScreen());
                        },
                        context: context,
                        text: S.of(context).addFranchise, // Use localization
                        width: size.width * 0.8 < 500 ? size.width * 0.8 : 500),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: defaultButton(
                        function: () {
                          navigateTo(context, const AddFranchiseScreen());
                        },
                        context: context,
                        text: S.of(context).addFranchise, // Use localization
                        width: size.width * 0.8 < 200 ? size.width * 0.8 : 200),
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
                              child: const FranchiseTable()
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