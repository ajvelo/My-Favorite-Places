import 'package:app/screens/add_place_screen.dart';
import 'package:flutter/material.dart';

class AddFavoritePlaceButton extends StatelessWidget {
  const AddFavoritePlaceButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
        });
  }
}
