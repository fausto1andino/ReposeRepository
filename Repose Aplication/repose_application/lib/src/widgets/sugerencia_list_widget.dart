import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repose_application/src/models/sugerencia_model.dart';
import 'package:repose_application/src/pages/sugerencia_page.dart';
import 'package:repose_application/src/providers/sugerencias_provider.dart';
import 'package:repose_application/src/widgets/sugerencia_card.dart';


class SugerenciaWidget extends StatelessWidget {
  const SugerenciaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sugerenciaProvider = Provider.of<SugerenciaProvider>(context, listen: true);
    return FutureBuilder<List<Sugerencia>>(
      future: sugerenciaProvider.loadElements(),
      builder: (context, snapshot){
         if (snapshot.hasError) {
            return const Center(
                child: SizedBox.square(
                    dimension: 50.0, child: Text("Un error ha ocurrido")));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox.square(
                  dimension: 50.0, child: CircularProgressIndicator()),
            );
          }
          return Scaffold(
            body: snapshot.data!.isEmpty
                ? const Center(
                    child: SizedBox.square(
                        dimension: 150.0,
                        child: Text("No hay datos en el SQLite")))
                : ListView(
                    children: snapshot.data!
                        .map((e) => SugerenciaCard(model: e))
                        .toList(),
                  ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SegurenciaFromPage(),
                    ),
                  );
                },
                child: const Icon(Icons.add)),
          );
        });
      }
  }
