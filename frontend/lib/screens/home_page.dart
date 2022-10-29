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
  var isFocus = false;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    isFocus = false;
    _focus.addListener(_onFocusChange);
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // Uncomment to change the background color
      // backgroundColor: CupertinoColors.systemPink,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurantes'),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(15, 55, 15, 15),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Pesquisar',
                    ),
                    focusNode: _focus,
                  )),
              Container(
                  child: _focus.hasFocus == false ? const Categories() : null),
              Flexible(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    itemCount: restaurants.sublist(0, 2).length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      title: InkWell(
                        child: RestaurantCard(
                            info: restaurants.sublist(0, 2)[index]),
                        onTap: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => RestaurantDetails(
                                info: restaurants.sublist(0, 2)[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: _focus.hasFocus == false
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 20, bottom: 10, top: 30),
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
                                child: CrossRestaurantCard(
                                    info: restaurants[index]),
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
                    itemCount: restaurants.sublist(2, 3).length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      title: InkWell(
                        child: RestaurantCard(
                            info: restaurants.sublist(2, 3)[index]),
                        onTap: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => RestaurantDetails(
                                info: restaurants.sublist(2, 3)[index]),
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
