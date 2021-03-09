import 'dart:io';

import 'package:app/helpers/db_helper.dart';
import 'package:app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        title: title,
        location: null);

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    final dbPath = await sql.getDatabasesPath();
    _items = dataList.map((e) {
      return Place(
          id: e['id'],
          image: File("$dbPath/${path.basename(e['image'])}"),
          title: e['title'],
          location: null);
    }).toList();
    notifyListeners();
  }
}
