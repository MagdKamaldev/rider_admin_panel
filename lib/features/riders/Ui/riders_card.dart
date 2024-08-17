import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Hubs/data/models/rider_model.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/features/riders/Ui/change_rider_hub.dart';
import 'package:tayar_admin_panel/features/riders/data/repos/riders_repo_impl.dart';
import 'package:tayar_admin_panel/features/riders/logic/cubit/rider_cubit.dart';

class RiderCard extends StatelessWidget {
  final RiderModel rider;

  const RiderCard({super.key, required this.rider});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(247, 250, 252, 1),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PopupMenuButton<int>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (int result) {
                    switch (result) {
                      case 0:
                        // Handle delete rider action
                        showDeleteRider(context);
                        break;
                      case 1:

                        // Handle edit rider action
                        break;
                      case 2:
                      navigateTo(context, ChangeRiderHubScreen(riderId: rider.id!,));
                        // Handle change hub action
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    const PopupMenuItem<int>(
                      value: 0,
                      child: ListTile(
                        leading: Icon(Icons.delete, color: Colors.red),
                        title: Text('Delete Rider'),
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: ListTile(
                        leading: Icon(Icons.edit, color: Colors.blue),
                        title: Text('Edit Rider'),
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: ListTile(
                        leading: Icon(Icons.swap_horiz, color: Colors.orange),
                        title: Text('Change Hub'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/images/delivery-bike.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 100);
                  },
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              rider.name ==null || rider.name ==""? 'N/A': rider.name!,
              style:
                  TextStyles.headings.copyWith(color: AppColors.prussianBlue),
            ),
            const SizedBox(height: 5.0),
            Text(
              rider.hubName ==null || rider.hubName ==""? 'N/A': rider.hubName!,
              style: TextStyles.headings
                  .copyWith(color: AppColors.prussianBlue.withOpacity(0.6), fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text('User ID: ${rider.userId ?? 'N/A'}'),
            Text('National ID: ${rider.nationalId ?? 'N/A'}'),
            Text('Phone: ${rider.mobileNumber ?? 'N/A'}'),
            Text('Queue No: ${rider.queueNo ?? 'N/A'}'),
            Text('Current Order ID: ${rider.currentOrderId ?? 'N/A'}'),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusIcon(Icons.check_circle, rider.isAvailable),
                _buildStatusIcon(Icons.directions_bike, rider.isInShift),
                _buildStatusIcon(Icons.headset, rider.isListening),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteRider(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => RiderCubit(getIt<RiderRepoImpl>()),
          child: BlocBuilder<RiderCubit, RiderState>(
            builder: (context, state) => AlertDialog(
              title: const Text("Are you sure you want to delete this Rider?"),
              actions: [
                TextButton(
                    onPressed: () {
                      RiderCubit.get(context).deleteRider(context, rider.id!);
                      navigateAndFinish(context, const HomeScreen());
                    },
                    child: const Text("Yes")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No")),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusIcon(IconData icon, bool? isActive) {
    return Icon(
      icon,
      color: isActive == true ? Colors.green : Colors.grey,
    );
  }
}
