import 'package:flutter/material.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';
import 'package:homework/widgets/home_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ACRCloudResponseMusicItem? music;

  @override
  void initState() {
    super.initState();
    // configuração para serviço de reconhecimento de àudio
    ACRCloud.setUp(ACRCloudConfig(
        "05ffa2061ebec72dc40f111f8c20e346",
        "1GfcTDF1AzV2rgcUT0uizbFODGymOQkgG5YV8hJ5",
        "identify-eu-west-1.acrcloud.com"));
  }

  // reconhecimento de àudio
  void findSong() async {
    setState(() {
      music = null;
    });

    final session = ACRCloud.startSession();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('A ouvir...'),
        content: StreamBuilder(
          stream: session.volumeStream,
          initialData: 0,
          builder: (_, snapshot) => Text(snapshot.data.toString()),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: session.cancel,
          )
        ],
      ),
    );

    final result = await session.result;
    Navigator.pop(context);

    if (result == null) {
      // Foi cancelado pelo utilizador
      return;
    } else if (result.metadata == null) {
      //não encontrou nenhuma música
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Nenhum resultado.'),
      ));
      return;
    } else {
      //encontrou música
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 240,
            color: Color.fromARGB(255, 30, 30, 30),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close_outlined),
                        iconSize: 30.0,
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        music!.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        music!.artists.first.name + " • " + music!.album.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                        child: ElevatedButton.icon(
                          onPressed: () => launch(
                              'https://open.spotify.com/search/' +
                                  music!.title +
                                  " - " +
                                  music!.artists.first.name),
                          label: Text(
                            "Ouvir no Spotify",
                            style: TextStyle(fontSize: 16),
                          ),
                          icon: Icon(Entypo.spotify),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: Size.fromHeight(70),
                              primary: Color.fromRGBO(30, 215, 96, 1),
                              onPrimary: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    setState(() {
      music = result.metadata!.music.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UAudio'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Descobrir Música'),
        icon: const Icon(Icons.music_note),
        onPressed: findSong,
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (context) => HomeWidget(),
        ),
      ),
    );
  }
}
