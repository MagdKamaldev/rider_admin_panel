import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/riders/Ui/add_rider_screen.dart';
import 'package:tayar_admin_panel/features/riders/Ui/riders_card.dart';
import 'package:tayar_admin_panel/features/riders/data/repos/riders_repo_impl.dart';
import 'package:tayar_admin_panel/features/riders/logic/cubit/rider_cubit.dart';
import 'package:tayar_admin_panel/generated/l10n.dart'; // Import the localization

class RidersScreen extends StatelessWidget {
  const RidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate number of columns based on screen width
        int columns = constraints.maxWidth > 1200
            ? 4
            : constraints.maxWidth > 800
                ? 3
                : constraints.maxWidth > 600
                    ? 2
                    : 1;

        // Calculate child aspect ratio based on screen width
        double aspectRatio = 0.6 * constraints.maxWidth / (columns * 270);

        return BlocProvider(
          create: (context) =>
              RiderCubit(getIt<RiderRepoImpl>())..fetchRiders(),
          child: BlocBuilder<RiderCubit, RiderState>(builder: (context, state) {
            return Skeletonizer(
              enabled: state is FetchRidersLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: defaultButton(
                      function: () {
                        navigateTo(context, const AddRiderScreen());
                      },
                      context: context,
                      text: S.of(context).addRider, // Localized text
                      width: constraints.maxWidth * 0.8 < 200
                          ? constraints.maxWidth * 0.8
                          : 200,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: RiderCubit.get(context).riders.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).noRidersYet, // Localized text
                                  style: TextStyles.headings.copyWith(
                                    color: AppColors.prussianBlue,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(8.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: aspectRatio,
                            ),
                            itemCount: RiderCubit.get(context).riders.length,
                            itemBuilder: (context, index) {
                              final rider =
                                  RiderCubit.get(context).riders[index];
                              return RiderCard(rider: rider);
                            },
                          ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
