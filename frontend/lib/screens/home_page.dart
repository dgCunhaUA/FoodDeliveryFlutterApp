import 'package:flutter/material.dart';
import 'package:flutter_project/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/utils/restaurants_info.dart';
import 'package:flutter_project/widgets/restaurant_card.dart';
import '../services/storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Storage _storage = Storage();
  String _token = "";

  @override

  /*
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

*/

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Restaurantes'),
            )
          ];
        },
        body: Center(
          child: Container(
            child: ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: RestaurantCard(info: restaurants[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
