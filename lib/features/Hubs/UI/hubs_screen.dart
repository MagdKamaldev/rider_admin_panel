// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Hubs/UI/add_hub_screen.dart';
import 'package:tayar_admin_panel/features/Hubs/UI/hub_table.dart';
import 'package:tayar_admin_panel/features/Hubs/data/repos/hubs_repo_impl.dart';
import 'package:tayar_admin_panel/features/Hubs/logic/cubit/hub_cubit.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class HubsScreen extends StatelessWidget {
  const HubsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final scrollController = ScrollController();
    return BlocProvider(
      create: (context) => HubCubit(getIt<HubsRepoImpl>())..fetchHubs(context),
      child: BlocBuilder<HubCubit, HubState>(
        builder: (context, state) {
          if (state is FetchHubsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (HubCubit.get(context).hubs.isEmpty) {
            return SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                  ),
                  Text(
                    S.of(context).noHubsYet,
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
                          navigateTo(context, const AddHubScreen());
                        },
                        context: context,
                        text: S.of(context).addHub,
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
                          navigateTo(context, const AddHubScreen());
                        },
                        context: context,
                        text: S.of(context).addHub,
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
                              child: const HubTable(),
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
