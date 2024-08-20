import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Hubs/UI/fixed_map.dart';
import 'package:tayar_admin_panel/features/Hubs/data/repos/hubs_repo_impl.dart';
import 'package:tayar_admin_panel/features/Hubs/logic/cubit/hub_cubit.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';

class HubDetails extends StatelessWidget {
  final int id;
  const HubDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScrollController mainPageScrollBarController = ScrollController();
    ScrollController riderScrollBarController = ScrollController();
    ScrollController branchScrollBarController = ScrollController();
    return BlocProvider(
      create: (context) =>
          HubCubit(getIt<HubsRepoImpl>())..fetchHub(context, id),
      child: BlocBuilder<HubCubit, HubState>(
        builder: (context, state) {
          if (state is FetchHubLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (HubCubit.get(context).hub == null) {
            return Scaffold(
                appBar: AppBar(),
                body: const Center(child: Text("No Data Found")));
          } else {
            Hub hub = HubCubit.get(context).hub!;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  hub.name!,
                  style: TextStyles.headings.copyWith(color: AppColors.ivory),
                ),
                backgroundColor: AppColors.prussianBlue,
              ),
              body: Scrollbar(
                controller: mainPageScrollBarController,
                child: SingleChildScrollView(
                  controller: mainPageScrollBarController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(hub.lat.toString()),
                        //  Text(hub.lng.toString()),
                        // Manager Section
                        _buildSectionTitle("Manager"),
                        _buildManagerTile(hub.managerName!, size),

                        // Divider
                        Divider(height: size.height * 0.05, thickness: 2),

                        // Riders Section
                        _buildSectionTitle("Riders"),
                        Scrollbar(
                          controller: riderScrollBarController,
                          child: _buildScrollableList(
                            size: size,
                            itemCount:
                                hub.riders == null ? 0 : hub.riders!.length,
                            itemBuilder: (context, index) {
                              return _buildListItem(hub.riders![index].name!,
                                  Icons.directions_bike, size);
                            },
                            heightFactor: 0.28,
                            scrollController: riderScrollBarController,
                          ),
                        ),

                        // Divider
                        Divider(height: size.height * 0.05, thickness: 2),

                        // Branches Section
                        _buildSectionTitle("Branches"),
                        Scrollbar(
                          controller: branchScrollBarController,
                          child: _buildScrollableList(
                              size: size,
                              itemCount: hub.branches == null
                                  ? 0
                                  : hub.branches!.length,
                              itemBuilder: (context, index) {
                                return _buildListItem(
                                    hub.branches![index].name!,
                                    Icons.store,
                                    size);
                              },
                              heightFactor: 0.28,
                              scrollController: branchScrollBarController),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: FixedMap(
                                fixedLocation: LatLng(hub.lat, hub.lng))),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyles.headings.copyWith(color: AppColors.prussianBlue),
    );
  }

  Widget _buildManagerTile(String manager, Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.prussianBlue.withOpacity(0.1),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, color: AppColors.prussianBlue),
          SizedBox(width: size.width * 0.02),
          Text(
            manager,
            style: TextStyles.headings.copyWith(color: AppColors.prussianBlue),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableList({
    required Size size,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    required double heightFactor,
    required ScrollController scrollController,
  }) {
    return SizedBox(
      height: size.height * heightFactor,
      child: ListView.builder(
        controller: scrollController,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }

  Widget _buildListItem(String name, IconData icon, Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.prussianBlue.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.indigoDye),
          SizedBox(width: size.width * 0.02),
          Text(
            name,
            style: TextStyles.headings.copyWith(color: AppColors.prussianBlue),
          ),
        ],
      ),
    );
  }
}
