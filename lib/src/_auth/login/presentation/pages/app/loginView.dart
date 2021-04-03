import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/recursos/images/images.dart';
import 'package:vet_app/src/_auth/login/domain/loginController.dart';
import 'package:vet_app/src/_auth/login/presentation/widgets/cardLogin.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) {
        return Scaffold(
          body: ListView(
            padding: EdgeInsets.only(
              top: context.height * 0.15,
              left: context.width * 0.1,
              right: context.width * 0.1,
            ),
            children: [
              Column(
                children: [
                  Hero(
                    tag: 'logo',
                    child: Image(
                      height: Get.height * 0.18,
                      image: AssetImage(imgLogoProypet),
                    ),
                  ),
                  SizedBox(height: 2.5),
                  Text(
                    'Proveedores',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              CardLogin(),
            ],
          ),
        );
      },
    );
  }
}