import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

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

class StorageController{
  StorageController._internal();

  static final StorageController _instance = StorageController._internal();
  factory StorageController() {
    return _instance;
  }

  Box<dynamic>? textListBox;
  Future init() async {
    textListBox = await Hive.openBox("textList");
  }

  void putTextList(List<Map<String,dynamic>> textList) {
    textListBox!.put("textList", textList);
  }

  List<Map<String,dynamic>> getTextList() {
    //convert the return type to List<Map<String,dynamic>>
    // map from dynamic to List<Map<String,dynamic>>

    List<Map<String,dynamic>> textList = [];

    if(textListBox!.get("textList") != null) {
      textListBox!.get("textList").forEach((element) {

        var mapped = Map<String,dynamic>.from(element);
        print("mapped");
        print(mapped);
        textList.add(mapped);
        // textList.add(Map<String,dynamic>.from(element));
      });
    }

    return textList;
  }
}