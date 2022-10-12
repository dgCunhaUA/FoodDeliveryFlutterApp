import 'package:flutter/material.dart';
import 'package:homework/widgets/album_card.dart';
import 'dart:convert';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString("assets/music_data.json"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Widget child;

            if (snapshot.hasData) {
              List showData = json.decode(snapshot.data.toString());

              child = GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemCount: showData.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return AlbumCard(
                      title: showData[index]["title"],
                      img: showData[index]["img"],
                      artist: showData[index]["artist"],
                      year: showData[index]["year"],
                      id: showData[index]["id"].toString(),
                      uri_s: showData[index]["uri_spotify"],
                    );
                  });
            } else {
              child = Container();
            }

            return Container(
              child: child,
            );
          }),
    );
  }
}
