import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/src/establishments/domain/create/createVetController.dart';
import 'package:vet_app/src/establishments/presentation/pages/_children/create/widgets/numStep.dart';

import 'bodyAddVet.dart';

class CreaVetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<CreateVetController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            leading: NumStep(),
            title: const Text('Crea establecimiento'),
          ),
          body: _.checked
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : BodyAddVet(),
        );
      },
    );
  }
}

//     Lottie.asset(
//       lottieLoading,
//       fit: BoxFit.cover,
//       height: 120,
//       repeat: false,
//     ),
