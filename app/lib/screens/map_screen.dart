import 'package:app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation? initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.422, longitude: -122.084),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Map"),
        actions: [
          if (widget.isSelecting)
            IconButton(
                icon: Icon(Icons.save),
                onPressed: _pickedPosition == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedPosition);
                      })
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation!.latitude,
                widget.initialLocation!.longitude),
            zoom: 16),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _pickedPosition == null
            ? {Marker(markerId: MarkerId('m1'))}
            : {Marker(markerId: MarkerId('m1'), position: _pickedPosition!)},
      ),
    );
  }
}
