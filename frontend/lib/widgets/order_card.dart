import 'package:flutter/material.dart';
import 'package:flutter_project/models/Order.dart';
import 'package:flutter_project/screens/validate_order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  bool? isValidated;

  OrderCard({super.key, required this.order, this.isValidated});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () => {
                if (isValidated != null)
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ValidateOrder(),
                      ),
                    )
                  }
                else
                  {
                    Navigator.pop(context, order.restaurantAddress) // TODO:
                  }
              },
              icon: isValidated != null
                  ? const Icon(Icons.qr_code)
                  : const Icon(Icons.delivery_dining),
              label: isValidated != null
                  ? const Text("Confimar Entrega")
                  : const Text("Iniciar Entrega"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 84, 204, 124),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(20.0)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "-----€",
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
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.trip_origin,
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(order.restaurantAddress),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(order.clientAddress),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
