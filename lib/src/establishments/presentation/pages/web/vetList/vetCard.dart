import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/components/buttons.dart';
import 'package:vet_app/components/childRegion.dart';
import 'package:vet_app/config/variablesGlobal.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/src/establishments/domain/establishmentsController.dart';

class VetCard extends StatelessWidget {
  final String id;
  final String image;
  final String name;
  final String ruc;
  final int aprobado;
  final int tipo;

  const VetCard(
    {
      @required this.id,
      @required this.image,
      @required this.name,
      @required this.ruc,
      @required this.aprobado,
      @required this.tipo
    });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EstablishmentsController>(
      builder: (_) {
        return ChildRegion(
          margin: EdgeInsets.all(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Container(
              width: 280,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 82.0,
                    width: 82.0,
                    decoration: BoxDecoration(
                      // color: tipo == 1 ? colorGreen : colorBlue,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(image),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    ruc,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 5),
                  Divider(),
                  SizedBox(height: 10),
                  // SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        aprobado == 1
                            ? Icons.check_box_rounded
                            : Icons.indeterminate_check_box_rounded,
                      ),
                      SizedBox(width: 10),
                      Text(aprobado == 1 ? 'Aprobado' : 'En espera'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.home_work_rounded),
                      SizedBox(width: 10),
                      Text(tipo == 1 ? 'Veterinaria' : 'Grooming'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Eliminar'),
                              content: Text(
                                  'Seguro que desea eliminar el establecimiento?'),
                              actions: <Widget>[
                                btnAltern(
                                  text: 'Sí, eliminar',
                                  bold: true,
                                  color: colorRed,
                                  onPressed: () {
                                    _.deldete(id);
                                    Get.back();
                                  },
                                ),
                                btnAltern(
                                  text: 'Cancelar',
                                  bold: true,
                                  onPressed: () => Get.back(),
                                ),
                              ],
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          height: 32.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            color: colorRed,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Establecimiento'),
                            content: Text(
                                'Seguro que desea cambiar de establecimiento?'),
                            actions: <Widget>[
                              btnAltern(
                                text: 'Sí, cambiar',
                                bold: true,
                                color: colorMain,
                                onPressed: () {
                                  _.favoriteVetToInit(id, name, image);
                                  // Get.back();
                                },
                              ),
                              btnAltern(
                                text: 'Cancelar',
                                bold: true,
                                onPressed: () => Get.back(),
                              ),
                            ],
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        height: 32.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: prefUser.vetId == id ? colorMain : Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Icon(
                          Icons.star_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    
  }
}
