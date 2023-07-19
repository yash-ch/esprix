import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefType { INT, STRING, BOOL }

class GlobalStateController {
  static final GlobalStateController state = GlobalStateController();
  ValueNotifier inLoading = ValueNotifier(false);

  ValueNotifier<List<Map<String,dynamic>>> textList = ValueNotifier([]);

  void updateTextList(List<Map<String,dynamic>> textList) {
    this.textList.value = textList;
  }
  
  void addToTextList(Map<String,dynamic> text) {
    textList.value.add(text);
    textList.notifyListeners();
  }

  void removeFromTextList(int index) {
    textList.value.removeAt(index);
    textList.notifyListeners();
  }

  void updateTextListAtIndex(int index, Map<String,dynamic> text) {
    textList.value[index] = text;
    textList.notifyListeners();
  }
}