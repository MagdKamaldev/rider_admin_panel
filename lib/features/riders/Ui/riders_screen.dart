import 'package:flutter/material.dart';
import 'package:tayar_admin_panel/features/Hubs/data/models/rider_model.dart';
import 'package:tayar_admin_panel/features/riders/Ui/riders_card.dart';

class RidersScreen extends StatelessWidget {
  final List<RiderModel> riders;

  const RidersScreen({super.key, required this.riders});

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
        double aspectRatio = 0.6 * constraints.maxWidth / (columns * 250);

        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: aspectRatio,
          ),
          itemCount: riders.length,
          itemBuilder: (context, index) {
            final rider = riders[index];
            return RiderCard(rider: rider);
          },
        );
      },
    );
  }
}