import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:homework/widgets/album_item.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:homework/screens/album.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  void partilharInfo(String title, String artist) {
    Share.share('Ouve esta música: $title - $artist');
  }

  // obter shared preferences, uma forma de guardar info no dispositivo
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List> awaitFilter() async {
    final SharedPreferences prefs = await _prefs;
    // receber a lista com as músicas que o user adicionou à biblioteca
    final List<String> songs = (prefs.getStringList('songs') ?? []);

    return songs;
  }

  //fazer update do estado, ao voltar dos detalhes da música
  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A tua Biblioteca'),
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 15),
          child: FutureBuilder(
            future: Future.wait([
              DefaultAssetBundle.of(context)
                  .loadString("assets/music_data.json"),
              awaitFilter()
            ]),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Widget child;

              if (snapshot.hasData) {
                var allData = json.decode(snapshot.data![0].toString());
                var showData = allData.where((i) {
                  if (snapshot.data[1].contains(i["id"].toString())) {
                    return true;
                  }
                  return false;
                }).toList();

                child = showData.length > 0
                    ? ListView.builder(
                        itemCount: (showData as List).length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            key: const ValueKey(0),
                            startActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (BuildContext context) async {
                                    // botão eliminar ativado

                                    // obter shared preferences
                                    final SharedPreferences prefs =
                                        await _prefs;

                                    // receber a lista de músicas guardadas
                                    final List<String> songs =
                                        (prefs.getStringList('songs') ?? []);

                                    // remover a música da lista
                                    if (songs.contains(
                                        showData[index]["id"].toString())) {
                                      songs.remove(
                                          showData[index]["id"].toString());
                                    }

                                    // atualizar estado com a nova lista
                                    setState(() {
                                      prefs.setStringList('songs', songs);
                                      snapshot.data[1].remove(
                                          showData[index]["id"].toString());
                                    });
                                  },
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete_outline,
                                  label: 'Eliminar',
                                ),
                                SlidableAction(
                                  onPressed: (BuildContext context) {
                                    partilharInfo(showData[index]["title"],
                                        showData[index]["artist"]);
                                  },
                                  backgroundColor: Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.ios_share_outlined,
                                  label: 'Partilhar',
                                ),
                              ],
                            ),
                            endActionPane: const ActionPane(
                              motion: DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: Color(0xFF7BC043),
                                  foregroundColor: Colors.white,
                                  icon: Icons.archive,
                                  label: 'Archive',
                                ),
                                SlidableAction(
                                  spacing: 4,
                                  onPressed: doNothing,
                                  backgroundColor: Color(0xFF0392CF),
                                  foregroundColor: Colors.white,
                                  icon: Icons.save,
                                  label: 'Save',
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Album(
                                          title: showData[index]["title"],
                                          img: showData[index]["img"],
                                          artist: showData[index]["artist"],
                                          year: showData[index]["year"],
                                          id: showData[index]["id"].toString(),
                                          uri_s: showData[index]
                                              ["uri_spotify"])),
                                ).then(onGoBack);
                              },
                              child: AlbumItem(
                                title: showData[index]["title"],
                                artist: showData[index]["artist"],
                                cover: showData[index]["img"],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: const Icon(
                                  Feather.music,
                                  color: Colors.white,
                                  size: 80.0,
                                ),
                              ),
                              const Text("Ainda sem músicas.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22)),
                              const Text("Adiciona títulos à tua biblioteca."),
                            ],
                          ),
                        ),
                      );
              } else {
                child = Container();
              }

              return Container(
                child: child,
              );
            },
          )),
    );
  }
}

void doNothing(BuildContext context) {}
