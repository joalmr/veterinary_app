import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vet_app/design/layout/main_layout.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/resources/utils/calcula_edad.dart';
import 'package:vet_app/resources/utils/datetime_format.dart';
import 'package:vet_app/src/registros/domain/get_attention_controller.dart';

import 'get_attention/detail.dart';

class GetAttention extends StatelessWidget {
  const GetAttention({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<GetAttentionsController>(
        init: GetAttentionsController(),
        builder: (_) {
          return MainLayout(
            drawerActive: true,
            title: 'Detalle de atención',
            body: _.loadingPage.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Card(
                        child: Container(
                          width: double.maxFinite,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(2.5),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image: CachedNetworkImageProvider(_
                                              .petData.value!.result!.picture!),
                                          fit: BoxFit.cover,
                                          height: 100,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2.5,
                                          bottom: 10,
                                        ),
                                        child: Text(
                                          _.petData.value!.result!.name!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      EasyRichText(
                                        'Tipo: ${_.petData.value!.result!.specieName}',
                                        defaultStyle: const TextStyle(
                                          color: Colors.black38,
                                          fontSize: 12,
                                        ),
                                        patternList: [
                                          EasyRichTextPattern(
                                            targetString: _.petData.value!
                                                .result!.specieName!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      EasyRichText(
                                        'Raza: ${_.petData.value!.result!.breedName}',
                                        defaultStyle: const TextStyle(
                                          color: Colors.black38,
                                          fontSize: 12,
                                        ),
                                        patternList: [
                                          EasyRichTextPattern(
                                            targetString: _.petData.value!
                                                .result!.breedName!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      EasyRichText(
                                        'Género: ${_.petData.value!.result!.genre.toString() == '1' ? 'Macho' : 'Hembra'}',
                                        defaultStyle: const TextStyle(
                                          color: Colors.black38,
                                          fontSize: 12,
                                        ),
                                        patternList: [
                                          EasyRichTextPattern(
                                            targetString: _.petData.value!
                                                        .result!.genre
                                                        .toString() ==
                                                    '1'
                                                ? 'Macho'
                                                : 'Hembra',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      EasyRichText(
                                        'Edad: ${calculateAge(_.petData.value!.result!.birthdate)!}',
                                        defaultStyle: const TextStyle(
                                          color: Colors.black38,
                                          fontSize: 12,
                                        ),
                                        patternList: [
                                          EasyRichTextPattern(
                                            targetString: calculateAge(_.petData
                                                .value!.result!.birthdate)!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      EasyRichText(
                                        'Peso: ${_.petData.value!.result!.weight}',
                                        defaultStyle: const TextStyle(
                                          color: Colors.black38,
                                          fontSize: 12,
                                        ),
                                        patternList: [
                                          EasyRichTextPattern(
                                            targetString: _
                                                .petData.value!.result!.weight
                                                .toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 4,
                            bottom: 4,
                          ),
                          child: Text(
                            'Fecha de atención: ${formatDateTime(_.attention.value.result!.attentionDate!)}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TabBar(
                                indicatorColor: colorMain,
                                labelColor: colorMain,
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                unselectedLabelColor: Colors.black54,
                                unselectedLabelStyle:
                                    TextStyle(fontWeight: FontWeight.normal),
                                tabs: [
                                  Tab(text: 'Servicios'),
                                  Tab(text: 'Files'),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: <Widget>[
                                    Container(
                                      child: ListView(
                                        children: [
                                          _.attention.value.result!
                                                      .attentionDetails !=
                                                  null
                                              ? detailAttention(_
                                                  .attention
                                                  .value
                                                  .result!
                                                  .attentionDetails)
                                              : SizedBox(height: 0)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: _.fileName.value.isEmpty
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child:
                                                          Text('Sin archivos'),
                                                    )
                                                  : InkWell(
                                                      onTap: () {},
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 4,
                                                              child: Text(_
                                                                  .fileName
                                                                  .value),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child:
                                                                    IconButton(
                                                                  onPressed: () =>
                                                                      _.deleteFile(),
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete_rounded,
                                                                    color:
                                                                        colorRed,
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      )),
                                            ),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1),
                                          Container(
                                            margin: const EdgeInsets.all(5.0),
                                            padding: const EdgeInsets.all(2.0),
                                            height: 120,
                                            width: 250,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border:
                                                  Border.all(color: colorMain),
                                            ),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              onTap: () {
                                                _.uploadFile();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Subir archivo',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    '*Puede subir un archivo de hasta 5Mb',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                width: double.maxFinite,
                                color: Colors.grey[300],
                                padding: EdgeInsets.only(right: 20),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('Monto'),
                                      Text(
                                        _.attention.value.result!
                                            .attentionAmount!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
          );
        });
  }
}
