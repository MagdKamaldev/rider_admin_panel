import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart'; // Make sure to import this for LatLng

class FixedMap extends StatelessWidget {
  final LatLng fixedLocation;
  const FixedMap(
      {super.key,
      required this.fixedLocation}); // Example location: San Francisco

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.prussianBlue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      width: size.width < 1200
          ? size.width * 0.9
          : 1200, // Smaller width for the map
      height: 500, // Smaller height for the map
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FlutterMap(
          options: MapOptions(
            interactionOptions:
                const InteractionOptions(flags: InteractiveFlag.none),
            initialCenter: fixedLocation,
            initialZoom: 11, // Fixed zoom level
            // interactiveFlags: InteractiveFlag.none, // Disable all interactions (no zoom, no pan)
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: fixedLocation,
                  width: 50,
                  height: 50,
                  child: const Icon(
                    Icons.location_pin,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
