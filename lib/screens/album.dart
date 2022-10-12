import 'package:flutter/material.dart';
import 'package:homework/utils/music_info.dart';
import 'package:homework/widgets/music_list.dart';
import "package:homework/widgets/more_info.dart";

class Album extends StatelessWidget {
  final String title, img, artist, year, id, uri_s;

  const Album({
    super.key,
    required this.title,
    required this.img,
    required this.artist,
    required this.year,
    required this.id,
    required this.uri_s,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: false,
                iconTheme: IconThemeData(color: Colors.white),
                leading: BackButton(color: Colors.white),
                backgroundColor: Color.fromARGB(255, 30, 30, 30),
                surfaceTintColor: Color.fromARGB(255, 30, 30, 30),
                expandedHeight: MediaQuery.of(context).size.width,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(this.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )),
                  background: new Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image(
                          image: AssetImage('assets/' + this.img),
                          fit: BoxFit.cover),
                      new DecoratedBox(
                        decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                                begin: FractionalOffset.bottomCenter,
                                end: FractionalOffset.center,
                                colors: [
                              Color.fromARGB(80, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0),
                            ])),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    labelColor: Color.fromRGBO(30, 215, 96, 1),
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      Tab(icon: Icon(Icons.graphic_eq_outlined), text: "Sobre"),
                      Tab(icon: Icon(Icons.lyrics_outlined), text: "Letra"),
                      Tab(
                          icon: Icon(Icons.format_list_bulleted),
                          text: "Álbum"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              MoreInfo(
                title: this.title,
                img: this.img,
                artist: this.artist,
                year: this.year,
                id: this.id,
                uri_s: this.uri_s,
              ),
              ListView(children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: const Text(
                    "Breathe, breathe in the air.\nDon't be afraid to care.\nLeave but don't leave me.\nLook around and choose your own ground.\n \nLong you live and high you fly\nAnd smiles you'll give and tears you'll cry\nAnd all you touch and all you see\nIs all your life will ever be.\n \nRun, rabbit run.\nDig that hole, forget the sun,\nAnd when at last the work is done\nDon't sit down it's time to dig another one.\n \nFor long you live and high you fly\nBut only if you ride the tide\nAnd balanced on the biggest wave\nYou race towards an early grave.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ]),
              MusicList(
                items: [
                  MusicInfo("Speak to Me", "1:05"),
                  MusicInfo("Breathe (In the Air)", "2:49"),
                  MusicInfo("On the Run", "3:45"),
                  MusicInfo("Time", "6:53"),
                  MusicInfo("The Great Gig in the Sky", "4:43"),
                  MusicInfo("Money", "6:22"),
                  MusicInfo("Us and Them", "7:49"),
                  MusicInfo("Any Colour You Like", "3:26"),
                  MusicInfo("Brain Damage", "3:46"),
                  MusicInfo("Eclipse", "2:12"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: Color.fromARGB(255, 30, 30, 30),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
