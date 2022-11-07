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
                  builder: (context) => OrderMap(
                    order: order,
                    isRider: false,
                  ),
                ),
              ),
              child: ListTile(
                  title: OrderCard(
                order: order,
                isRider: false,
              )),
            ),
          ),
        );
      },
    );
  }
}
