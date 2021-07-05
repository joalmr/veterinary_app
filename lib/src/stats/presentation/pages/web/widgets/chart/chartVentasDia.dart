import 'package:flutter/material.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/src/stats/presentation/widgets/dataTemp/data_ventas_dia.dart';

import '../../../../widgets/design_graph.dart';

class ChartVentasDia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return chartDesign(
      title: 'Ventas por día',
      widget: Container(
        padding: const EdgeInsets.all(10),
        child: _chartBar(dataVentasDia),
      ),
    );
  }
}

Widget _chartBar(List<DataDay> listDay) {
  double numeromayor = 0;
  for (int i = 0; i < listDay.length && i < listDay.length; i++) {
    if (listDay[i].value! > numeromayor) {
      numeromayor = listDay[i].value!;
    }
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: listDay
        .map(
          (e) => _barDay(
            e.name!,
            e.value!,
            numeromayor,
          ),
        )
        .toList(),
  );
}

Widget _barDay(String day, double value, double mayor) {
  final double valorY = (value * 150) / mayor;
  // double ancho = (400 - (10 * 2)) / 7;

  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.5),
        height: 150,
        width: 40.0,
        decoration: const BoxDecoration(
          color: Color(0xffF6F6FC),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Container(
          height: valorY,
          width: 35.0,
          decoration: const BoxDecoration(
            color: colorGreen,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                value.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      ),
      // Container(
      //   height: 5,
      //   width: ancho,
      //   color: Colors.red,
      // ),
      const SizedBox(height: 5),
      Text(
        day.substring(0, 3),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ],
  );
}
