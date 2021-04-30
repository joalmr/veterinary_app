import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/resources/utils/days/diaSemana.dart';
import 'package:vet_app/src/establishments/domain/create/createVetController.dart';
import 'package:vet_app/src/establishments/presentation/pages/_children/create/widgets/checkHorario.dart';
import 'package:vet_app/src/establishments/presentation/pages/_children/create/widgets/dataTipo.dart';



class Step3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<CreateVetController>(
      builder: (_) {
        return Container(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              SizedBox(height: 15),
              Text(
                'Personal',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Divider(),
              Text('Tipo'),
              Material(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      value: _.personalType,
                      items: personalTipo.map((ItemService value) {
                        return new DropdownMenuItem<String>(
                          value: value.id,
                          child: new Text(value.name),
                        );
                      }).toList(),
                      onChanged: (val) {
                        print(val);
                        _.personalType = val;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre y apellido'),
                controller: _.v.personalNameVet,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 15),
              _.personalType == '2'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Código CMV'),
                          controller: _.v.personalCodeVet,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    )
                  : SizedBox(height: 0),
              SizedBox(height: 15),
              Text(
                'Horario',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Divider(),
              for (var i = 0; i < 7; i++)
                CheckHorario(
                  iniController: _.v.iniController[i],
                  endController: _.v.endController[i],
                  day: diaSemana[i],
                  index: i,
                ),
              SizedBox(height: 15),
              Text(
                'Precios',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Divider(),
              TextFormField(
                decoration: InputDecoration(labelText: 'Consulta'),
                controller: _.v.moneyConsulta,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: 'Desparasitación'),
                controller: _.v.moneyDesparasita,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: 'Vacuna'),
                controller: _.v.moneyVacuna,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: 'Grooming'),
                controller: _.v.moneyGrooming,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 5),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}