import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vet_app/assets/images/lotties.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/src/stablishments/domain/createVetController.dart';
import 'package:vet_app/src/stablishments/view/_children/create/shared/addVet/components/numStep.dart';

import 'bodyAddVet.dart';

class CreaVetView extends StatelessWidget {
  const CreaVetView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateVetController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            leading: NumStep(),
            title: Text('Crea establecimiento'),
            centerTitle: false,
          ),
          body: _.v.checked
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        lottieCheck,
                        fit: BoxFit.cover,
                        height: 120,
                        repeat: false,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Registro exitoso!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: colorMain,
                        ),
                      ),
                    ],
                  ),
                )
              : BodyAddVet(),
        );
      },
    );
  }
}
