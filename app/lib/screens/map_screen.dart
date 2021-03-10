import 'package:app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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
  LatLng? currentPosition;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  Future<LatLng> _getCurrentLocation() async {
    try {
      final location = await Location().getLocation();
      return LatLng(location.latitude!, location.longitude!);
    } catch (error) {
      return LatLng(37.422, -122.084);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pickedPosition == null) {
          _pickedPosition = currentPosition;
        }
        Navigator.of(context).pop(_pickedPosition);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("My Map"),
            actions: [
              if (widget.isSelecting)
                IconButton(
                    icon: Icon(Icons.save),
                    onPressed: _pickedPosition == null
                        ? null
                        : () {
                            Navigator.of(context).pop(_pickedPosition!);
                          })
            ],
          ),
          body: FutureBuilder<LatLng>(
            builder: (context, snapshot) {
              currentPosition = snapshot.data;
              return snapshot.hasData
                  ? GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: currentPosition!, zoom: 16),
                      onTap: widget.isSelecting ? _selectLocation : null,
                      markers: _pickedPosition == null
                          ? {
                              Marker(
                                  markerId: MarkerId('m1'),
                                  position: currentPosition!)
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
            future: _getCurrentLocation(),
          )),
    );
  }
}
