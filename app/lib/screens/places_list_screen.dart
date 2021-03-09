import 'package:app/providers/great_places.dart';
import 'package:app/widgets/add-favorite-place-btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Favorite Places'),
          actions: [AddFavoritePlaceButton()],
        ),
        body: Consumer<GreatPlaces>(
          builder: (context, value, child) {
            return value.items.length <= 0
                ? child!
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(value.items[index].image),
                        ),
                        title: Text(value.items[index].title),
                        onTap: () {
                          // Go to detail page
                        },
                      );
                    },
                    itemCount: value.items.length,
                  );
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Add a favorite place!'),
                AddFavoritePlaceButton()
              ],
            ),
          ),
        ));
  }
}
