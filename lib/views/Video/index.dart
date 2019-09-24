import 'package:flutter/material.dart';
import 'player.dart';

class Video extends StatefulWidget {
  Video({ Key key }) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => VideoState();
}

class VideoState extends State<Video> {
  VideoState() : super();

  List<Widget> videoList () {
    final List video = [
      {
        'text': 'butterfly',
        'type': 'asset',
        'url': 'lib/assets/video/butterfly.mp4',
      },
      {
        'text': 'bee',
        'type': 'network',
        'url': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      },
    ];
    return List.generate(video.length, (int index) {
      return Container(
        color: Colors.black,
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.amberAccent,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${video[index]['type']}: ${video[index]['text']}', style: TextStyle(
                    fontSize: 20
                  ),),
                ],
              ),
            ),
            VideoPlayer(url: video[index]['url'], type: video[index]['type']),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
        backgroundColor: Colors.amberAccent,
      ),
      body: ListView(
        children: videoList()
      ),
    );
  }
}
