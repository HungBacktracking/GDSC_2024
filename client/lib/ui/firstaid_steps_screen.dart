import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/themes.dart';
class StepScreen extends StatefulWidget {
  final String appBarTitle;
  final List<String> steps;

  StepScreen({Key? key, required this.appBarTitle, required this.steps}) : super(key: key);

  @override
  _StepScreenState createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'kGI7Kj3n9o4', // Id of the video to be played.
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.appBarTitle,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
          ),
      ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: <Widget>[
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          const Gap(20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.steps.length,
              itemBuilder: (context, index) {
                return StepTag(content: widget.steps[index], index: index);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class StepTag extends StatelessWidget {
  final String content;
  final int index;

  StepTag({required this.content, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyTheme.lightRedBackGround,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
      child: InkWell(
        onTap: () {
          // Handle the tap event for this category
        },
        child: Container(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/numbers/num_${index + 1}.png'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0), // Add padding to left side for the text
                  child: Text(
                    content,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
