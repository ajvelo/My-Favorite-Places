import 'package:app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:path/path.dart';

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
  Future<LatLng>? _currentPosition;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  Future<LatLng>? _getCurrentLocation() async {
    try {
      final location = await Location().getLocation();
      return LatLng(location.latitude!, location.longitude!);
    } catch (error) {
      return LatLng(37.422, -122.084);
    }
  }

  @override
  void initState() {
    super.initState();
    _currentPosition = _getCurrentLocation();
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
        body: FutureBuilder<LatLng>(
          builder: (context, snapshot) {
            final currentPosition = snapshot.data;
            return snapshot.hasData
                ? GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: currentPosition!, zoom: 16),
                    onTap: widget.isSelecting ? _selectLocation : null,
                    markers: _pickedPosition == null
                        ? {
                            Marker(
                                markerId: MarkerId('m1'),
                                position: currentPosition)
                          }
                        : {
                            Marker(
                                markerId: MarkerId('m1'),
                                position: _pickedPosition!)
                          },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
          future: _currentPosition,
        ));
  }
}
