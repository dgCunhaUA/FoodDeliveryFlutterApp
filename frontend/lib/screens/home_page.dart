import 'package:flutter/material.dart';
import 'package:flutter_project/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/screens/restaurant_details.dart';
import 'package:flutter_project/utils/restaurants_info.dart';
import 'package:flutter_project/widgets/categories.dart';
import 'package:flutter_project/widgets/cross_restaurant_card.dart';
import 'package:flutter_project/widgets/restaurant_card.dart';
import '../services/storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Storage _storage = Storage();
  String _token = "";

  @override
  initState() {
    super.initState();

    _storage.getToken().then((token) => {
          if (token != null)
            {
              setState(() {
                _token = token;
              }),
            }
          else
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()))
            }
        });
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
        margin: EdgeInsets.only(top: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(margin: EdgeInsets.only(top: 35), child: Categories()),
              Flexible(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    itemCount: restaurants.sublist(0, 2).length,
                    physics: NeverScrollableScrollPhysics(),
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
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 10, top: 30),
                      child: Text(
                        "Recomendações para si",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 190,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: CrossRestaurantCard(info: restaurants[index]),
                        ),
                      ),
                    ),
                  ],
                ),
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
