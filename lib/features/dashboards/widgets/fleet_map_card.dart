import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/bus_status.dart';
import '../../fleet/logic/fleet_cubit.dart';

class FleetMapCard extends StatelessWidget {
  const FleetMapCard({super.key});

  Color _statusColor(BusStatus status) {
    switch (status) {
      case BusStatus.running:
        return Colors.green;
      case BusStatus.boarding:
        return Colors.orange;
      case BusStatus.available:
        return Colors.blue;
      case BusStatus.maintenance:
        return Colors.amber;
      case BusStatus.offline:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final buses = context.watch<FleetCubit>().state.buses
        .where((b) => b.latitude != 0 || b.longitude != 0)
        .toList();

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
              markers: buses
                  .map(
                    (bus) => Marker(
                  point: LatLng(bus.latitude, bus.longitude),
                  width: 60,
                  height: 60,
                  child: Icon(
                    Icons.directions_bus,
                    color: _statusColor(bus.status),
                    size: 38,
                  ),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}