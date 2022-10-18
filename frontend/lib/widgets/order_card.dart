import 'package:flutter/material.dart';
import 'package:flutter_project/screens/validate_order.dart';

class OrderCard extends StatefulWidget {
  final Map item_info;
  bool? isValidated;
  OrderCard({super.key, required this.item_info, this.isValidated});

  @override
  State<OrderCard> createState() => _OrderCardState(item_info, isValidated);
}

class _OrderCardState extends State<OrderCard> {
  final Map item_info;
  bool? isValidated;
  _OrderCardState(this.item_info, this.isValidated);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Color.fromARGB(255, 227, 227, 233)),
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: () => {
                  if (isValidated == null)
                    {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ValidateOrder(),
                        ),
                      )
                    }
                },
                icon: isValidated != null
                    ? Icon(Icons.check)
                    : Icon(Icons.qr_code),
                label: isValidated != null
                    ? Text("Validado")
                    : Text("Validar entrega"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 84, 204, 124),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.all(20.0)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      item_info["price"].toString() + "€",
                      style: TextStyle(
                        fontSize: 42,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      "inclui gorjetas expectáveis",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: Colors.black,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(item_info["time"].toString() +
                        "min (" +
                        item_info["distance"].toString() +
                        "km) no total"),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.trip_origin,
                          color: Colors.black,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4),
                          child: Text(item_info["restaurant"]),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4),
                          child: Text(item_info["destination"]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}