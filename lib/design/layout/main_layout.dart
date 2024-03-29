import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/components/app/menu.dart';
import 'package:vet_app/components/web/navigation_bar.dart';

import 'main_controller.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final bool drawerActive;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool floatingABOnlyApp;
  MainLayout({
    Key? key,
    required this.body,
    this.drawerActive = false,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.floatingABOnlyApp = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLaoutController>(
      init: MainLaoutController(),
      builder: (_) {
        return Scaffold(
          appBar: (context.width < 900)
              ? AppBar(
                  title: Text(title ?? ''),
                  actions: actions,
                )
              : null,
          drawer: (context.width < 900 && drawerActive) ? MenuDrawer() : null,
          body: context.width < 900
              ? body
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NavigationBar(),
                    Expanded(
                      child: body,
                    ),
                  ],
                ),
          floatingActionButton: floatingActionButton,
        );
      },
    );
  }
}
