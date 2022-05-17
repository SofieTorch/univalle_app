import 'package:flutter/material.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/theme/app_colors.dart';

class ProceduresPage extends StatelessWidget {
  const ProceduresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _ProceduresView();
  }
}

class _ProceduresView extends StatelessWidget {
  const _ProceduresView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pageTitleProcedures),
      ),
      //Create Cards
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              //metodos para los card
              const ProcedureCard(),
              const ProcedureCard(),
              const ProcedureCard(),
              Container(
                height: 130,
                width: 300,
                child: Text(
                  'Requisitos:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
class ProcedureCard extends StatelessWidget {
  const ProcedureCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          const SizedBox(height: 4),
          const Text('Certificado de calificaciones',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: AppColors.matterhorn),
              ),
          const SizedBox(height: 4),
          const Text('6 dias estimados',
                style: TextStyle(fontSize: 12.0, color: AppColors.gray),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Chip(label: const Text('Precisa factura',style: TextStyle(color: AppColors.matterhorn),), backgroundColor: AppColors.shiraz.shade100),
                      const SizedBox(width: 4,),
                      Chip(label: const Text('Costo 50bs.',style: TextStyle(color: AppColors.matterhorn),), backgroundColor: AppColors.gray.shade200),
                    ],
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ), 
        ],
    );
  }
}

