import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/orders/orders_bloc.dart';
import 'package:flutter_project/models/Order.dart';
import 'package:flutter_project/screens/loading.dart';
import 'package:flutter_project/screens/order_map.dart';
import 'package:flutter_project/widgets/order_card.dart';

class ClientOrdersView extends StatelessWidget {
  const ClientOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const LoadingScreen();
          } else if (state is OrdersLoadedSuccess) {
            return _buildListViewOrders(state.orders);
          } else {
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
                  builder: (context) => OrderMap(order: order),
                ),
              ),
              child: ListTile(
                title: _buildCard(
                  order,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard(Order order) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  order.orderStatus,
                  style: const TextStyle(
                    fontSize: 42,
                    height: 1.2,
                  ),
                ),
                if (order.riderName != null) ...[
                  Text(
                    order.riderName!,
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
  }
}
