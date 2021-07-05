import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/register_controller.dart';

import 'app/register_view.dart';
import 'web/register_page.dart';

class RegisterMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (_) {
        return context.width < 900
            ? const RegisterView()
            : const RegisterPage();
      },
    );
  }
}
