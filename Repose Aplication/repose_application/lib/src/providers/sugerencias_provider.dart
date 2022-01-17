import 'package:flutter/cupertino.dart';
import 'package:repose_application/src/models/sugerencia_model.dart';
import 'package:repose_application/src/providers/db_provider.dart';



class SugerenciaProvider extends ChangeNotifier {
  List<Sugerencia> elements = [];

  Future<Sugerencia> addElement(Sugerencia model) async {
    final id = await DBProvider.dbProvider.insert(model);
    model.id = id;
    elements.add(model);
    notifyListeners();
    return model;
  }

  Future<List<Sugerencia>> loadElements() async {
    elements = await DBProvider.dbProvider.list();
    return elements;
  }
}