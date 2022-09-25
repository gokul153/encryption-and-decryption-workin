import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ui/db/model/data_model.dart';

ValueNotifier<List<messagemodel>> messagelistnotifier = ValueNotifier([]);

Future<void> addmessage(messagemodel value) async {
  messagelistnotifier.value.add(value);

  final messageDB = await Hive.openBox<messagemodel>('messagedb');
  int _id = await messageDB.add(value);
  print("returned id is $_id");
  value.id = _id;
  
  print(value.toString());
  messagelistnotifier.notifyListeners();
}

Future<void> getAllmessages() async {
  final messageDB = await Hive.openBox<messagemodel>('messagedb');
  messagelistnotifier.value.clear();
  messagelistnotifier.value.addAll(messageDB.values);

  messagelistnotifier.notifyListeners();
}

Future<void> deletemessage(int id) async {
  final messageDB = await Hive.openBox<messagemodel>('messagedb');
  await messageDB.delete(id);
  //messagelistnotifier.notifyListeners();
  getAllmessages();
}

Future<void> deleteall() async {
  final messageDB = await Hive.openBox<messagemodel>('messagedb');
  messageDB.deleteAll(messageDB.keys);
  getAllmessages();
}
