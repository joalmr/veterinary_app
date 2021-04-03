import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/recursos/images/images.dart';
import 'package:vet_app/src/_auth/login/presentation/widgets/cardLogin.dart';
import 'package:vet_app/src/_auth/login/presentation/widgets/portada.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Portada(),
          Expanded(
            child: Container(
              child: Center(
                child: Container(
                  width: 500,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        SizedBox(height: 30),
                        CardLogin(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
