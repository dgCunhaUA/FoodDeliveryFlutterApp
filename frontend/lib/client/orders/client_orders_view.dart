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
          print(state);

          if (state is OrdersLoading) {
            return const LoadingScreen();
          } else if (state is OrdersLoadedSuccess) {
            return _buildOrders(state.orders);
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }

  Widget _buildOrders(orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        Order order = orders[index];

        return Card(
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderMap(order: order),
              ),
            ),
            child: ListTile(
              title: OrderCard(
                order: order,
              ),
            ),
          ),
        );
      },
    );
  }
}
