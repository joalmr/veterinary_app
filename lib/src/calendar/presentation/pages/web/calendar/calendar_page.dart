import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:vet_app/resources/utils/days/dia_semana_lite.dart';
import 'package:vet_app/src/calendar/presentation/widgets/full_calendar.dart';
import 'package:vet_app/resources/utils/months_name.dart';
import 'package:vet_app/design/styles/styles.dart';
import 'package:vet_app/src/calendar/presentation/widgets/eventList/events_booking.dart';
import 'package:vet_app/src/calendar/presentation/widgets/eventList/events_next_date.dart';
import 'package:vet_app/src/calendar/presentation/widgets/eventList/events_note.dart';
import 'package:vet_app/src/home/presentation/pages/web/dashboard/widgets/tab_select.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

int valueDay = DateTime.now().day;
int valueMonth = DateTime.now().month; //DateTime(2021, 4, 0).month;
int valueYear = DateTime.now().year;

int daysPerMonth = DateTime(valueYear, valueMonth + 1, 0).day;
int selected = 0;

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(width: 50),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_left_rounded),
                onPressed: () {
                  setState(() {
                    if (valueMonth > 1) {
                      valueMonth = valueMonth - 1;
                      daysPerMonth = DateTime(valueYear, valueMonth + 1, 0).day;
                      valueDay = 1;
                    } else {
                      valueYear = valueYear - 1;
                      valueMonth = 12;
                      daysPerMonth = DateTime(valueYear, valueMonth + 1, 0).day;
                    }
                  });
                },
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '${monthsName[valueMonth]}, $valueYear',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_right_rounded),
                onPressed: () {
                  setState(() {
                    if (valueMonth < 12) {
                      valueMonth = valueMonth + 1;
                      daysPerMonth = DateTime(2021, valueMonth + 1, 0).day;
                      valueDay = 1;
                    } else {
                      valueYear = valueYear + 1;
                      valueMonth = 1;
                      daysPerMonth = DateTime(valueYear, valueMonth + 1, 0).day;
                    }
                  });
                },
              ),
              const SizedBox(width: 50),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            // key: _keyBody,
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: daysPerMonth,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final int dayNum = numWeekDay(valueYear, valueMonth, index + 1);

                final bool daySelected =
                    valueDay == DateTime(valueYear, valueMonth, index + 1).day;
                return Container(
                  width: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: daySelected ? colorGreen : Colors.grey[200],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        valueDay = index + 1;
                      });
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          diaSemanaLite[dayNum - 1],
                          style: TextStyle(
                            color: daySelected ? Colors.white : null,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: daySelected ? Colors.white : null,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 50),
              InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: () {
                  setState(() {
                    selected = 0;
                  });
                },
                child: tabSelect(
                  selected: selected == 0,
                  text: 'Reservas',
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: () {
                  setState(() {
                    selected = 1;
                  });
                },
                child: tabSelect(
                  selected: selected == 1,
                  text: 'Próximas citas',
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: () {
                  setState(() {
                    selected = 2;
                  });
                },
                child: tabSelect(
                  selected: selected == 2,
                  text: 'Eventos',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ConditionalSwitch.single<int>(
            context: context,
            valueBuilder: (BuildContext context) => selected,
            caseBuilders: {
              0: (BuildContext context) => const EventsBooking(),
              1: (BuildContext context) => const EventsNextDate(),
              2: (BuildContext context) => const EventsNote(),
            },
            fallbackBuilder: (BuildContext context) => const EventsBooking(),
          ),
        ],
      ),
    );
  }
}