import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String name;
  final String desc;
  final int price;
  final String img;

  const Item(
    this.name,
    this.desc,
    this.price,
    this.img,
  );

  @override
  List<Object?> get props => [name, desc, price, img];
}
