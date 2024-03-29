import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_app/components/buttons.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/resources/icons/proypet_icons.dart';
import 'package:vet_app/routes/routes.dart';
import 'package:vet_app/src/bookings/domain/booking_controller.dart';
import 'package:vet_app/src/bookings/presentation/pages/reprogramar/app/reprogramar.dart';

class CardAttention extends StatefulWidget {
  final String bookingId;
  final String petId;
  final String petImg;
  final String petName;
  final String petBreed;
  final String status;
  final String date;
  final String time;
  final String userName;
  final String userPhone;
  final Color color;
  final List<String> bookingServices;
  final String observation;
  final String address;
  final String delivery;
  final int attentionType;

  CardAttention({
    required this.bookingId,
    required this.petId,
    required this.petImg,
    required this.petName,
    required this.petBreed,
    required this.status,
    required this.date,
    required this.time,
    required this.userName,
    required this.userPhone,
    required this.color,
    required this.bookingServices,
    required this.observation,
    required this.address,
    required this.delivery,
    required this.attentionType,
  });

  @override
  _CardAttentionState createState() => _CardAttentionState();
}

class _CardAttentionState extends State<CardAttention> {
  bool more = false;

  @override
  Widget build(BuildContext context) {
    String stringTypes = '';
    for (var i = 0; i < widget.bookingServices.length; i++) {
      final element = widget.bookingServices[i];
      if (widget.bookingServices.length == 1) {
        stringTypes = element;
      } else {
        if (i < widget.bookingServices.length - 1) {
          stringTypes += '$element, ';
        } else {
          stringTypes += element;
        }
      }
    }

    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 68.0,
                                  width: 68.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            widget.petImg),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.petName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(widget.petBreed),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: widget.color,
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                          ),
                                          height: 7.5,
                                          width: 7.5,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          widget.status,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${widget.date} ${widget.time}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Usuario',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(widget.userName),
                                Text(widget.userPhone),
                                SizedBox(height: 5),
                                Text(
                                  'Tipo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(stringTypes),
                                SizedBox(height: 5),
                                Text(
                                  'Observaciones',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  widget.observation == ''
                                      ? '-'
                                      : widget.observation,
                                  maxLines: 5,
                                ),
                                SizedBox(height: 5),
                                if (widget.delivery != '' &&
                                    widget.address != '')
                                  Card(
                                    color: Colors.grey[200],
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      width: double.maxFinite,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(IconProypet.delivery),
                                          SizedBox(height: 5),
                                          Text(
                                            widget.delivery,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 5),
                                          Text(widget.address),
                                        ],
                                      ),
                                    ),
                                  )
                                else
                                  SizedBox(height: 0)
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              //* tipo de atencion
                              if (widget.attentionType == 3)
                                SizedBox(width: 0)
                              else
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 7.5),
                                    child: btnSecondary(
                                      text: 'Atender',
                                      onPressed: () async {
                                        final _book =
                                            Get.find<BookingController>();
                                        _book.bookingId.value =
                                            widget.bookingId;
                                        _book.petId.value = widget.petId;
                                        await _book.initLoad();
                                        Get.toNamed(NameRoutes.atenderBooking);
                                      },
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 7.5, right: 20),
                                  child: btnSecondary(
                                    text: 'Reprogramar',
                                    color: Colors.grey[600]!,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return ReprogramarItem(
                                            bookingId: widget.bookingId,
                                            petImg: widget.petImg,
                                            petName: widget.petName,
                                            petBreed: widget.petBreed,
                                            date: widget.date,
                                            time: widget.time,
                                            userName: widget.userName,
                                            userPhone: widget.userPhone,
                                            color: widget.color,
                                            status: widget.status,
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            leading: Container(
              height: 48.0,
              width: 48.0,
              decoration: BoxDecoration(
                // color: widget.color,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(widget.petImg)),
                ),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.petName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(widget.petBreed),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      height: 7.5,
                      width: 7.5,
                    ),
                    SizedBox(width: 5),
                    Text(
                      widget.status,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    children: [
                      Icon(
                        more ? Icons.expand_less : Icons.expand_more_rounded,
                        size: 14,
                        color: colorMain,
                      ),
                      Text(
                        'Ver más',
                        style: TextStyle(
                          color: colorMain,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  widget.time,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
