import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/resources/images/images.dart';
import 'package:vet_app/src/_auth/presentation/register/widgets/card_register.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
          top: context.height * 0.05,
          left: context.width * 0.1,
          right: context.width * 0.1,
        ),
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 700),
            child: JelloIn(
              duration: const Duration(milliseconds: 600),
              child: Column(
                children: [
                  Image(
                    height: Get.height * 0.18,
                    image: AssetImage(imgLogoProypet),
                  ),
                  const SizedBox(height: 2.5),
                  const Text(
                    'Proveedores',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const CardRegister(),
        ],
      ),
    );
  }
}
