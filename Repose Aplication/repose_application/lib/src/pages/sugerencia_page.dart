import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repose_application/src/models/sugerencia_model.dart';
import 'package:repose_application/src/providers/sugerencias_provider.dart';

class SegurenciaFromPage extends StatefulWidget {
  const SegurenciaFromPage({Key? key}) : super(key: key);

  @override
  _SegurenciaFromPageState createState() => _SegurenciaFromPageState();
}

class _SegurenciaFromPageState extends State<SegurenciaFromPage> {
  final _formKey = GlobalKey<FormState>();
  late Sugerencia _model;
  bool _onSaving = false;

  final List<String> _typesElement = ['5 Estrellas', '4 Estrellas', '3 Estrellas', '2 Estrellas', '1 Estrella'];
  String _typeSelected = "5 Estrellas";

@override
  void initState() {
    super.initState();
    _model = Sugerencia.created();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sugerenciaProvider = Provider.of<SugerenciaProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Ingrese su Sugerencia")),
      body: SingleChildScrollView(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                height: size.height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorDark,
            ])),
              ),
              Column(
                children: [
                  SizedBox.square(dimension: 120.h),
                  Text("Registre su Sugerencia",
                  style: Theme.of(context).textTheme.headline5),
                  Container(
                      margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 14.0),
                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                     width: size.width * .80,
                     decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        width: 2.0, color: Theme.of(context).primaryColorDark)),
                    child: Form(
                      key: _formKey,
                      child:  Padding(padding:  const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 7.0),
                          child: Column(
                            children: [
                              DropdownButton<String>(
                            value: _typeSelected,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            underline: Container(height: 2),
                            onChanged: (String? newValue) {
                              _model.valoracion = _typesElement.indexOf(newValue!);
                              setState(() {
                                _typeSelected = newValue;
                              });
                            },
                            items: _typesElement
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: _model.titulo,
                              onSaved: (value) {
                                //Este evento se ejecuta cuando se cumple la validación y cambia el estado del Form
                                _model.titulo = value.toString();
                              },
                              validator: (value) {
                                return _validateAsunto(value!);
                              },
                              decoration:
                                  const InputDecoration(labelText: "Asunto"),
                              maxLength: 50),
                              TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: _model.comentario,
                              onSaved: (value) {
                                //Este evento se ejecuta cuando se cumple la validación y cambia el estado del Form
                                _model.comentario = value.toString();
                              },
                              validator: (value) {
                                return _validateCometario(value!);
                              },
                              decoration: const InputDecoration(
                                  labelText: "Comentario"),
                              maxLength: 255,
                              maxLines: 3),
                                _onSaving
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                  child: CircularProgressIndicator())
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Tooltip(
                                    message: "Registrar insumo utilizado",
                                    child: ElevatedButton.icon(
                                        onPressed: () async {
                                          if (!_formKey.currentState!
                                              .validate()) return;
                                          _onSaving = true;
                                          setState(() {});

                                          //Vincula el valor de las controles del formulario a los atributos del modelo
                                          _formKey.currentState!.save();

                                          _model = await sugerenciaProvider
                                              .addElement(_model);
                                          if (_model.id != null) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        label: const Text("Guardar"),
                                        icon: const Icon(Icons.save)),
                                  ),
                                )
                            ],
                          ),
                          )
                      ),
                  ),
                ],
              )
            ],
          ),
      ),
    
    );
  
  }
    String? _validateCometario(String value) {
    if (value.length < 3) {
      return "Mínimo 3 carácteres para el módelo";
    }
    return null;
  }

  String? _validateAsunto(String value) {
     String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Ingrese alguna letra para continuar";
    } else if (!regExp.hasMatch(value)) {
      return 'Por favor solo ingrese letras';
    }
    return null;
  }
}