import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/models/Order.dart';
import 'package:flutter_project/rider/orders/orders_bloc.dart';
import 'package:flutter_project/screens/validate_order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final bool isRider;

  const OrderCard({
    super.key,
    required this.order,
    required this.isRider,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RiderOrdersBloc, RiderOrdersState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              if (isRider) ...[
                ElevatedButton.icon(
                  onPressed: () => {
                    if (order.orderStatus == "Delivering")
                      {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ValidateOrder(),
                          ),
                        )
                        //print("finalizar order.")
                      }
                    else
                      {
                        //Navigator.pop(context, order.restaurantAddress) // TODO:
                        context.read<RiderOrdersBloc>().add(
                              AcceptOrder(order),
                            ),

                        context.read<RiderOrdersBloc>().add(
                              FectingOrders(),
                            ),
                      }
                  },
                  icon: order.orderStatus == "Delivering"
                      ? const Icon(Icons.qr_code)
                      : const Icon(Icons.delivery_dining),
                  label: order.orderStatus == "Delivering"
                      ? const Text("Confimar Entrega")
                      : const Text("Iniciar Entrega"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 84, 204, 124),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(20.0)),
                ),
              ] else ...[
                // Client show QR code
                if (order.orderStatus == "Delivering") ...[
                  ElevatedButton.icon(
                    onPressed: () => {},
                    icon: const Icon(Icons.qr_code),
                    label: const Text("Mostrar QR code"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 84, 204, 124),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(20.0)),
                  ),
                ]
              ],
              Container(
                margin: const EdgeInsets.symmetric(vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isRider) ...[
                      const Text(
                        "3€",
                        style: TextStyle(
                          fontSize: 42,
                          height: 1.2,
                        ),
                      ),
                      const Text(
                        "inclui gorjetas expectáveis",
                        style: TextStyle(fontSize: 12),
                      ),
                    ] else ...[
                      Text(
                        order.orderStatus,
                        style: const TextStyle(
                          fontSize: 42,
                          height: 1.2,
                        ),
                      ),
                      Text(
                        order.riderName ?? "",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
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
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              overflow: TextOverflow.fade,
                              order.restaurantAddress,
                            ),
                          ),
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
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              overflow: TextOverflow.fade,
                              order.clientAddress,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
