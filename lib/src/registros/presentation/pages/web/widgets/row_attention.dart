import 'package:flutter/material.dart';
import 'package:vet_app/components/buttons.dart';

class RowAttention extends StatefulWidget {
  final String? petName;
  final String? petBreed;
  final String? date;
  final String? time;
  final String? userName;

  final String? amount;

  const RowAttention({
    this.petName,
    this.petBreed,
    this.date,
    this.time,
    this.userName,
    this.amount,
  });

  @override
  _RowAttentionState createState() => _RowAttentionState();
}

class _RowAttentionState extends State<RowAttention> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (value) {
        setState(() {
          hovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 275),
        margin: const EdgeInsets.only(bottom: 10.0, left: 40.0, right: 15.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: hovered
                ? [
                    const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 13.0,
                    ),
                  ]
                : []),
        child: SizedBox(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    const SizedBox(width: 15.0),
                    Container(
                      height: 38.0,
                      width: 38.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: const Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/dog.jpg'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.petName!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          widget.petBreed!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '${widget.date} ${widget.time}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      const Text(
                        'Servicios',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 10.0,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Wrap(
                        children: const [
                          Icon(Icons.home, size: 16),
                          Icon(Icons.home, size: 16),
                          Icon(Icons.home, size: 16),
                          Icon(Icons.home, size: 16),
                          Icon(Icons.home, size: 16),
                          Icon(Icons.home, size: 16),
                          Icon(Icons.home, size: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Usuario',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 10.0,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.userName!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      const Text(
                        'Precio',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 10.0,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'S/ ${widget.amount}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: btnPrimary(
                  text: 'Ver',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
