import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/screens/restaurant_details.dart';
import 'package:flutter_project/utils/restaurants_info.dart';
import 'package:flutter_project/widgets/categories.dart';
import 'package:flutter_project/widgets/cross_restaurant_card.dart';
import 'package:flutter_project/widgets/restaurant_card.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FocusNode _focus = FocusNode();

  List info_rest = restaurants;
  List hor_info_rest = restaurants.toList();

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    info_rest = restaurants;
    hor_info_rest.shuffle();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {});

    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  void filterRestaurants(rest_name) {
    setState(() {
      if (rest_name == "") {
        info_rest = restaurants;
      } else {
        info_rest = restaurants
            .where((i) =>
                i["name"].toString().toLowerCase().contains(RegExp(rest_name)))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // Uncomment to change the background color
      // backgroundColor: CupertinoColors.systemPink,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('DeliveryApp'),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(15, 105, 15, 15),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Pesquisar',
                    ),
                    focusNode: _focus,
                    onChanged: (value) {
                      filterRestaurants(value);
                    },
                  )),
              Container(
                  child: _focus.hasFocus == false ? const Categories() : null),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: _focus.hasFocus == false
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 10),
                            child: Text(
                              "Recomendações para si",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 190,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                  child: CrossRestaurantCard(
                                      info: hor_info_rest[index]),
                                  onTap: () {
                                    showCupertinoModalBottomSheet(
                                      context: context,
                                      builder: (context) => RestaurantDetails(
                                          info: hor_info_rest[index]),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
              Flexible(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    itemCount: info_rest.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      title: InkWell(
                        child: RestaurantCard(info: info_rest[index]),
                        onTap: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                RestaurantDetails(info: info_rest[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
