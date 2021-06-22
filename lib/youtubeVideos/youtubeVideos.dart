/* import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class videoPlayer extends StatefulWidget {
  final url = 'https://www.youtube.com/watch?v=ATI7vfCgwXE';
  @override
  _videoPlayerState createState() => _videoPlayerState();
}

class _videoPlayerState extends State<videoPlayer> {
  YoutubePlayerController _controller;

  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
        flags: YoutubePlayerFlags(
          enableCaption: false,
          isLive: false,
          autoPlay: false,
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    runYoutubePlayer();
    super.initState();
  }

  @override
  void deactive() {
    // TODO: implement dispose
    _controller.pause();
    super.deactivate();
  }

  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
        ),
        builder: (context, player) {
          return Column(
            children: [
              player,
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Get More Information Plese visit Our Web Page",
                style: TextStyle(
                    color: Colors.lightGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Image.asset(
                'assets/images/homeSlider/m4.png',
                fit: BoxFit.cover,
              ),
              RaisedButton(
                color: Colors.amber[100],
                onPressed: () {},
                child: Text(
                  'Visit',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        });
  }
}
 */
