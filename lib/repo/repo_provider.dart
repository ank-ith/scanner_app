import 'package:flutter/material.dart';

class FavItem {
  String name;
  String price;
  String image;

  FavItem({required this.name, required this.price, required this.image});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavItem &&
        other.name == name &&
        other.price == price &&
        other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ image.hashCode;
}

class FavProvider with ChangeNotifier {
  List<FavItem> favorites = [];



  void addToFav(FavItem item) {
    if (!favorites.contains(item)) {
      favorites.add(item);
      notifyListeners();
    }
  }

  void removeFav(FavItem item) {
    favorites.remove(item);
    notifyListeners();
  }

  void logout() {
    favorites.clear();
    notifyListeners();
  }
}