import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/rider/orders/orders_bloc.dart';
import 'package:flutter_project/models/Order.dart';
import 'package:flutter_project/screens/loading.dart';
import 'package:flutter_project/screens/order_map.dart';
import 'package:flutter_project/widgets/order_card.dart';

class RiderOrdersView extends StatelessWidget {
  const RiderOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<RiderOrdersBloc, RiderOrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const LoadingScreen();
          } else if (state is OrdersLoadedSuccess) {
            return _buildListViewOrders(state.orders);
          } else {
            context.read<RiderOrdersBloc>().add(FectingOrders());
            return const LoadingScreen();
          }
        },
      ),
    );
  }

  Widget _buildListViewOrders(orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        Order order = orders[index];

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderMap(
                    order: order,
                    isRider: false,
                  ),
                ),
              ),
              child: ListTile(title: _buildOrderCard(order)),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildOrderCard(Order order) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
    child: Column(
      children: [
        ElevatedButton.icon(
          onPressed: () => {
            if (order.orderStatus == "Delivering")
              {
                /* Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ValidateOrder(),
                      ),
                    ) */
                print("finalizar order.")
              }
            else
              {
                //Navigator.pop(context, order.restaurantAddress) // TODO:
                print("Aceitar order !!!!!1")
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
        Container(
          margin: const EdgeInsets.symmetric(vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                "3€",
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
}
