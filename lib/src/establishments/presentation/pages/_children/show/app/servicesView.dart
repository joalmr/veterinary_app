import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/components/buttons.dart';
import 'package:vet_app/recursos/utils/icons_map.dart';
import 'package:vet_app/src/establishments/domain/edit/editVetController.dart';

class ServicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<EditVetController>(
      builder: (_) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 0.0,
                  bottom: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Servicios",
                      style: Get.textTheme.subtitle2.apply(fontWeightDelta: 2),
                    ),
                    IconButton(
                      splashRadius: 20,
                      iconSize: 18,
                      icon: Icon(
                        Icons.edit,
                      ),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 40,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Editar servicios',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  //
                                  SizedBox(height: 15),
                                  Center(
                                    child: btnSecondary(
                                      text: 'Guardar',
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Center(
                                    child: btnAltern(
                                      text: 'Volver',
                                      onPressed: () => Get.back(),
                                      bold: true,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              for (var i = 0; i < _.establishment.services.length; i++)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Get.theme.backgroundColor, //Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 3.0,
                                spreadRadius: 2.0)
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            iconNum[_.establishment.services[i].id],
                            size: 20,
                            color: Get.textTheme.subtitle2.color,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        textMap[_.establishment.services[i].id],
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}