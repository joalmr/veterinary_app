import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/components/dont_exit.dart';
import '../../domain/stats_controller.dart';

import 'app/stats_app.dart';
import 'web/stats_web.dart';

class StatsMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatsController>(
      init: StatsController(),
      builder: (_) {
        return DontExit(
          child: context.width < 900 ? StatsPageApp() : StatsPageWeb(),
        );
      },
    );
  }
}
