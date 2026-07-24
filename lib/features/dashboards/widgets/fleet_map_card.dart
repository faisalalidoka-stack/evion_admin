import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FleetMapCard extends StatelessWidget {
  const FleetMapCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 500,
        child: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(0.3136, 32.5811),
            initialZoom: 12,
          ),
          children: [
            TileLayer(
              urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.evion.admin',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: const LatLng(0.3136, 32.5811),
                  width: 60,
                  height: 60,
                  child: const Icon(
                    Icons.directions_bus,
                    color: Colors.blue,
                    size: 38,
                  ),
                ),
                Marker(
                  point: const LatLng(0.3476, 32.5825),
                  width: 60,
                  height: 60,
                  child: const Icon(
                    Icons.directions_bus,
                    color: Colors.green,
                    size: 38,
                  ),
                ),
                Marker(
                  point: const LatLng(0.2980, 32.6100),
                  width: 60,
                  height: 60,
                  child: const Icon(
                    Icons.directions_bus,
                    color: Colors.orange,
                    size: 38,
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