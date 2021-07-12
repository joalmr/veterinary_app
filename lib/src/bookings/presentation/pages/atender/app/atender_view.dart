import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/components/buttons.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/resources/icons/proypet_icons.dart';
import 'package:vet_app/resources/utils/calcula_edad.dart';
import 'package:vet_app/resources/utils/datetime_format.dart';
import 'package:vet_app/src/_pet/presentation/pages/pet_history/view.dart';
import 'package:vet_app/src/bookings/domain/booking_controller.dart';
import 'child/cirugia/cirugia_view.dart';
import 'child/consulta/consulta_view.dart';
import 'child/desparasita/desparasita_view.dart';
import 'child/grooming/grooming_view.dart';
import 'child/otro/otro_view.dart';
import 'child/testing/testing_view.dart';
import 'child/vacuna/vacuna_view.dart';
import 'components/proximaCita/proxima_cita.dart';
import 'components/tipos_atencion_list.dart';

class AtenderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<BookingController>(
      // init: BookingController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Atención'),
          ),
          body: _.loadingPage.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image(
                                height: 100,
                                width: 100,
                                image: CachedNetworkImageProvider(_.image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        _.petData.value.result!.name!,
                                        style: Get.textTheme.subtitle1!
                                            .apply(fontWeightDelta: 2),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.pets_rounded,
                                        size: 18,
                                        color: colorMain,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                      'Edad: ${calculateAge(_.petData.value.result!.birthdate)}'),
                                  Text(
                                      'Tipo: ${_.petData.value.result!.specieName!}'),
                                  Text(
                                      'Raza: ${_.petData.value.result!.breedName!}'),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.book_rounded),
                              onPressed: () {
                                Get.to(PetHistoryPage(), arguments: _.idSplit);
                              },
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: TextFormField(
                          controller: _.pesoController,
                          decoration: InputDecoration(
                            labelText: 'Peso',
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text('Condición'),
                      ),
                      Material(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                        // child: Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 5),
                        //   child: DropdownButtonHideUnderline(
                        //     child: DropdownButton(
                        //       isExpanded: true,
                        //       value: _.condicion,
                        //       items: condicionLista.map((value) {
                        //         return new DropdownMenuItem<String>(
                        //           value: value.id,
                        //           child: Text(value.name),
                        //         );
                        //       }).toList(),
                        //       onChanged: (val) {
                        //         print(val);
                        //         // _.condicion.value = val.toString();
                        //       },
                        //     ),
                        //   ),
                        // ),
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: SizedBox(
                          child: SingleChildScrollView(
                            child: !_.statusBooking.value
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      tipoAtencion(
                                        IconProypet.consulta,
                                        'Consulta',
                                        _.consulta.value?.amount?.toString() ??
                                            '',
                                        () => Get.to(() => ConsultaView()),
                                      ),
                                      tipoAtencion(
                                        IconProypet.cirugia,
                                        'Cirugía',
                                        _.cirugia.value?.amount?.toString() ??
                                            '',
                                        () => Get.to(CirugiaView()),
                                      ),
                                      tipoAtencion(
                                        IconProypet.desparasitacion,
                                        'Desparasitación',
                                        _.desparasita.value?.amount
                                                ?.toString() ??
                                            '',
                                        () => Get.to(DesparasitaView()),
                                      ),
                                      tipoAtencion(
                                        IconProypet.grooming,
                                        'Grooming',
                                        'falta',
                                        () => Get.to(GroomingView()),
                                      ),
                                      tipoAtencion(
                                        IconProypet.vacuna,
                                        'Vacuna',
                                        _.vacunas.value?.amount?.toString() ??
                                            '',
                                        () => Get.to(VacunaView()),
                                      ),
                                      tipoAtencion(
                                        IconProypet.tuboEnsayo,
                                        'Exámenes',
                                        _.examenes.value?.amount?.toString() ??
                                            '',
                                        () => Get.to(TestingView()),
                                      ),
                                      tipoAtencion(
                                        IconProypet.farmacia,
                                        'Otros',
                                        _.otros.value?.amount?.toString() ?? '',
                                        () => Get.to(OtroView()),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 5),
                                        child: Text(
                                          'Próximas citas',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            itemCitas(
                                                text: 'Consulta',
                                                slug: 'consultation'),
                                            itemCitas(
                                                text: 'Desparasitación',
                                                slug: 'deworming'),
                                            itemCitas(
                                                text: 'Grooming',
                                                slug: 'grooming'),
                                            itemCitas(
                                                text: 'Vacunas',
                                                slug: 'vaccination'),
                                          ],
                                        ),
                                      ),
                                      if (_.listNextdate.isEmpty)
                                        Center(
                                            child: Padding(
                                          padding: EdgeInsets.only(top: 35),
                                          child: Text('Sin próximas citas'),
                                        ))
                                      else
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (var item in _.listNextdate)
                                              Container(
                                                width: double.maxFinite,
                                                margin: EdgeInsets.all(5),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          item.name!,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        IconButton(
                                                          onPressed: () => _
                                                              .removeList(item),
                                                          icon: Icon(
                                                            Icons
                                                                .delete_forever_rounded,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    DateTimePicker(
                                                      dateMask: 'dd-MM-yyyy',
                                                      initialValue: formatDate(
                                                          DateTime.now()),
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime.now()
                                                          .add(Duration(
                                                              days: 730)),
                                                      dateLabelText: 'Fecha',
                                                      onChanged: (val) =>
                                                          item.date = val,
                                                    ),
                                                    SizedBox(height: 5),
                                                    TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Observación',
                                                      ),
                                                      onChanged: (value) => item
                                                          .observation = value,
                                                      initialValue:
                                                          item.observation,
                                                      maxLines: 2,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: !_.statusBooking.value
                              ? Padding(
                                  padding: Platform.isIOS
                                      ? EdgeInsets.only(bottom: 15)
                                      : EdgeInsets.zero,
                                  child: btnPrimary(
                                    text: 'Continuar',
                                    onPressed: () {
                                      _.statusBooking.value = true;
                                    },
                                  ),
                                )
                              : Padding(
                                  padding: Platform.isIOS
                                      ? EdgeInsets.only(bottom: 15)
                                      : EdgeInsets.zero,
                                  child: Row(
                                    children: [
                                      btnSecondary(
                                        text: 'Volver',
                                        onPressed: () {
                                          _.statusBooking.value = false;
                                        },
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: btnPrimary(
                                          text: 'Finalizar atención',
                                          onPressed: () => _.saveFinalize(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
