import 'package:flutter/material.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Hubs/data/models/rider_model.dart';

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
            const SizedBox(height: 16.0),
            Text(
              rider.name ?? 'N/A',
              style:
                  TextStyles.headings.copyWith(color: AppColors.prussianBlue),
            ),
             const SizedBox(height: 8.0),
            Text(
              rider.hubName ?? 'N/A',
              style:
                  TextStyles.headings.copyWith(color: AppColors.prussianBlue, fontSize: 16),
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

  Widget _buildStatusIcon(IconData icon, bool? isActive) {
    return Icon(
      icon,
      color: isActive == true ? Colors.green : Colors.grey,
    );
  }
}
