import 'package:discover_ease/functionality/auto_complete_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final placeResultsProvider = ChangeNotifierProvider<PlaceResults>((ref) {
return PlaceResults();
});
final searchToggleProvider = ChangeNotifierProvider<SearchToggle>((ref){
return SearchToggle();
});

class PlaceResults extends ChangeNotifier{
  List<AutoCompleteResult> allReturnedResults = [];
  void setResults(allPlaces){
    allReturnedResults = allPlaces;
    notifyListeners();
  }
}

class SearchToggle extends ChangeNotifier{
  bool searhToggle = false;

  void toggleSearch(){
    searhToggle = !searhToggle;
    notifyListeners();
  }
}