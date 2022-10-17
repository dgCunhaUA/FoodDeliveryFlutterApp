import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/order_card.dart';

final item = [
  {
    'id': 'jpxcQ00rLy',
    "price": 27.82,
    "time": 26,
    "distance": 4.7,
    "restaurant": "La Grotta",
    "destination": "Rua João Afonso 17"
  }
];

class Orders extends StatelessWidget {
  final bool? isValidated;
  const Orders({super.key, this.isValidated});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Builder(builder: (context) {
        return Container(
          child: ListView.builder(
            itemCount: item.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: OrderCard(
                  item_info: item[index],
                  isValidated: isValidated,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
