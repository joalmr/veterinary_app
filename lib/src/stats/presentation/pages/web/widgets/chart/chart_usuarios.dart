import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/src/stats/domain/stats_controller.dart';
import 'package:vet_app/src/stats/presentation/widgets/dataTemp/data_usuario.dart';
import '../../../../widgets/design_graph.dart';

class ChartUsers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChartUsersState();
}

class ChartUsersState extends State<ChartUsers> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatsController>(
      builder: (_) {
        return chartDesign(
          title: 'Usuarios Mensual',
          widget: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: _chartBar(dataUsuario),
          ),
        );
      },
    );
  }

  Widget _chartBar(List<DataUsuario> listData) {
    int numeromayor = 0;
    for (int i = 0; i < listData.length && i < listData.length; i++) {
      if (listData[i].value! > numeromayor) {
        numeromayor = listData[i].value!;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: listData
          .map(
            (e) => _barUsuario(
              e.name!,
              e.value!,
              numeromayor,
            ),
          )
          .toList(),
    );
  }

  Widget _barUsuario(String day, int value, int mayor) {
    final double valorY = (value * 150) / mayor;
    // double ancho = (400 - (40 * 2)) / 3;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.5),
          height: 150,
          width: 60.0,
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
            width: 55.0,
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
}
