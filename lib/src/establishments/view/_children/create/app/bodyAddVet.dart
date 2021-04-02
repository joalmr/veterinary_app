import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/src/establishments/domain/create/createVetController.dart';
import 'package:vet_app/src/establishments/view/_children/create/shared/components/rowFooter.dart';
import '../shared/components/bodyStep.dart';
import '../shared/components/headerStep.dart';

class BodyAddVet extends StatelessWidget {
  const BodyAddVet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CreateVetController>(
      builder: (_) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20),
                  HeaderStep(selected: _.v.selected),
                ],
              ),
            ),
            BodyStep(selected: _.v.selected),
            FooterCreateVet(),
          ],
        );
      },
    );
  }
}
