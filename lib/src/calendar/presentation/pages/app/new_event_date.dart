import 'package:date_time_picker/date_time_picker.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vet_app/components/buttons.dart';
import 'package:vet_app/src/calendar/domain/calendar_controller.dart';

class NewEventDate extends StatelessWidget {
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(
      builder: (_) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Agregar evento',
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Título'),
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (val) => _.titulo.value = val,
                ),
                const SizedBox(height: 15),
                DateTimePicker(
                  dateMask: 'dd-MM-yyyy',
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 3),
                  dateLabelText: 'Fecha',
                  onChanged: (val) => _.fecha.value = val,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Hora'),
                  enableInteractiveSelection: false,
                  controller: timeController,
                  readOnly: true,
                  onTap: () {
                    final format = DateFormat('HH:mm');
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: _.pickedTime,
                        onChange: (TimeOfDay newTime) => _.pickedTime = newTime,
                        is24HrFormat: true,
                        minuteInterval: MinuteInterval.TEN,
                        maxMinute: 50,
                        barrierDismissible: false,
                        iosStylePicker: true,
                        hourLabel: 'horas',
                        minuteLabel: 'minutos',
                        okText: 'Aceptar',
                        cancelText: 'Cancelar',
                        onChangeDateTime: (DateTime dateTime) {
                          _.hora.value = format.format(dateTime);
                          timeController.text = _.hora.value;
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Integrantes'),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (val) => _.integrantes.value = val,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (val) => _.descripcion.value = val,
                  maxLength: 150,
                  maxLines: 5,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: btnPrimary(
                    text: 'Agregar',
                    onPressed: _.newCalendarEvent,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ));
      },
    );
  }
}
