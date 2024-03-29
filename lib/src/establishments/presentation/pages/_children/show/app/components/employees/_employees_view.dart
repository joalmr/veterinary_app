import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/src/establishments/data/model/establishmet.dart';

import '../../widgets/employee_show.dart';
import 'edit_employees_view.dart';

class EmployeesView extends StatelessWidget {
  final List<Employee> employees;
  const EmployeesView({Key? key, required this.employees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 10.0,
              bottom: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Empleados',
                  style: Get.textTheme.subtitle2!.apply(fontWeightDelta: 2),
                ),
                GetPlatform.isWeb
                    ? SizedBox(height: 0)
                    : IconButton(
                        splashRadius: 20,
                        iconSize: 18,
                        icon: const Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          Get.to(EditEmployeesView());
                        },
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: employees
                  .map(
                    (e) => employee(
                      type: e.typeId,
                      name: e.name,
                      code: e.code,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
