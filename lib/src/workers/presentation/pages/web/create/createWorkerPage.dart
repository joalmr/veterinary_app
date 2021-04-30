import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/components/buttons.dart';
import 'package:vet_app/components/childRegion.dart';
import 'package:vet_app/components/subheader.dart';
import 'package:vet_app/config/variablesGlobal.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/resources/utils/datetimeFormat.dart';
import 'package:vet_app/src/workers/domain/workersController.dart';

class CreaAdmin extends StatelessWidget {
  //! mensaje cuando ya no puede invitar a un administrador
  @override
  Widget build(BuildContext context) {
    // final emailFocusNode = FocusScope.of(context);

    return GetX<WorkersController>(
      builder: (_) {
        return Container(
          color: Color(0xffF7F7FF),
          child: 
          _.carga.value
          ? Center(child: CircularProgressIndicator())
          : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              subHeader(title: "Invitar administrador a ${prefUser.vetName}",),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _.emailText,
                      decoration: InputDecoration(labelText: 'Email del administrador a invitar'),
                      keyboardType: TextInputType.emailAddress,
                      // focusNode: emailFocusNode,
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      width: double.infinity,
                      child: btnPrimary(
                        text: 'Enviar invitación',
                        onPressed: (){
                          // emailFocusNode.unfocus();
                          _.setInvita();
                        } 
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Divider(),
              Container(
                margin: EdgeInsets.only(
                  left: 30.0,
                ),
                child: Text("Invitaciones pendientes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: 
                _.workersInvitation.length == 0
                ? Center(
                    child: Text('No tiene invitaciones pendientes de respuesta'),
                  )
                : 
                ListView.builder(
                  itemCount: _.workersInvitation.length,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  itemBuilder: (BuildContext context, int index) {
                    final workerInvitation = _.workersInvitation[index];
                    return ChildRegion(
                      margin: EdgeInsets.all(10),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fecha de invitación',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            Text(formatDate(workerInvitation.createdAt),),
                            SizedBox(height: 2.5),
                            Text(
                              'Establecimiento',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              workerInvitation.establishmentName,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 2.5),
                            Text(
                              'Correo electrónico',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            Text(workerInvitation.email),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () => _.deleteInvita(workerInvitation.id),
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                height: 32.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                  color: colorRed,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
