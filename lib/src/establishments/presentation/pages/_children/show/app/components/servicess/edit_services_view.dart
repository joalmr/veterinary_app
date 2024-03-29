import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/components/buttons.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/src/establishments/domain/edit/edit_services_controller.dart';

class EditServicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<EditServicesController>(
      init: EditServicesController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Editar servicios'),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: _.servicesVet
                      .map(
                        (item) => Container(
                          margin: const EdgeInsets.only(
                              left: 2, right: 2, bottom: 8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () => _.add2List(item.id!),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: _.servicesVetSet.contains(item.id)
                                    ? colorGreen.withAlpha(225)
                                    : colorGreen.withAlpha(50),
                              ),
                              child: Text(item.name!),
                            ),
                          ),
                        ),
                      )
                      .toList()
                      .cast<Widget>(),
                ),
                const SizedBox(height: 20),
                Center(
                  child: btnSecondary(
                    text: 'Guardar',
                    onPressed: _.servicesVet.isEmpty ? null : _.updateServices,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
