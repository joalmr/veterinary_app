import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/src/establishments/domain/establishments_controller.dart';
import 'components/card_vet.dart';

class VetsView extends StatelessWidget {
  // final refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return GetX<EstablishmentsController>(
      builder: (_) {
        return 
        _.establecimientos.isEmpty ?
        Center(child: Text('No tiene establecimientos'),)
        :
         ListView.builder(
          itemCount: _.establecimientos.length,
          itemBuilder: (BuildContext context, int index) {
            final establecimiento = _.establecimientos[index];
            return CardEstablecimiento(
              id: establecimiento.id!,
              image: establecimiento.logo!,
              name: establecimiento.name!,
              ruc: establecimiento.ruc!,
              aprobado: establecimiento.status!,
              tipo: establecimiento.type!,
            );
          },
        );
      },
    );
  }
}
