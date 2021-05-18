import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:vet_app/components/childRegion.dart';
import 'package:vet_app/design/styles/styles.dart';

class EventNextDate extends StatelessWidget {
  final String image;
  final String petName;
  final String petBreed;
  final String motivo;
  final String userName;
  final bool firstPush;
  final bool secondPush;

  const EventNextDate({
    Key key,
    @required this.image,
    @required this.petName,
    @required this.petBreed,
    @required this.motivo,
    @required this.userName,
    @required this.firstPush,
    @required this.secondPush,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: context.width > 900 ? 40 : 15,
        right: context.width > 900 ? 20 : 10,
        top: 5,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.pinkAccent,
      ),
      child: ChildRegion(
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image(
                height: context.width > 900 ? 80 : 75,
                width: context.width > 900 ? 80 : 55,
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(image),
              ),
            ),
            SizedBox(width: context.width > 900 ? 20 : 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  petName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(petBreed),
                Text(
                  motivo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorMain,
                  ),
                ),
                Text(userName),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 75),
                      child: Row(
                        children: [
                          Icon(
                            firstPush
                                ? Icons.notifications_active_rounded
                                : Icons.notifications_off_rounded,
                            color: firstPush ? colorGreen : null,
                          ),
                          SizedBox(width: 5),
                          Icon(
                            secondPush
                                ? Icons.notifications_active_rounded
                                : Icons.notifications_off_rounded,
                            color: secondPush ? colorGreen : null,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      splashRadius: 10,
                      icon: Icon(LineAwesomeIcons.whatsapp),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
