import 'package:app/providers/great_places.dart';
import 'package:app/screens/add_place_screen.dart';
import 'package:app/screens/place_detail_screen.dart';
import 'package:app/screens/places_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'My Favorite Places',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(primary: Colors.indigo)),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(primary: Colors.amber),
            )),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen()
        },
      ),
    );
  }
}
