import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/scaler.dart';
class StepScreen extends StatefulWidget {
  final String appBarTitle;
  final List<String> steps;
  final String youtubeId;

  StepScreen({Key? key, required this.appBarTitle, required this.steps, required this.youtubeId}) : super(key: key);

  @override
  _StepScreenState createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId, // Id of the video to be played.
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appBarTitle,
          style: TextStyle(
            fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 25.0 * scaler.widthScaleFactor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white, // Assuming your AppBar background is white
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
            SizedBox(height: 30 * scaler.widthScaleFactor), // Replacing Gap(20) for standard SizedBox for spacing
            ...widget.steps.asMap().entries.map((entry) {
              int index = entry.key;
              String step = entry.value;
              return StepTag(content: step, index: index);
            }).toList(),
            SizedBox(height: 20 * scaler.widthScaleFactor), // Replacing Gap(20) for standard SizedBox for spacing
          ],
        ),
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
    Scaler().init(context);
    Scaler scaler = Scaler();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0 * scaler.widthScaleFactor, vertical: 5.0 * scaler.widthScaleFactor),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0 * scaler.widthScaleFactor),
        color : Colors.grey[300]?.withOpacity(0.3),
      ),
      child: Expanded(
        child: InkWell(
          onTap: () {
            // Handle the tap event for this category
          },
          child: Container(
            padding: EdgeInsets.only(top: 8.0 * scaler.widthScaleFactor, bottom: 8.0 * scaler.widthScaleFactor, left: 13.0 * scaler.widthScaleFactor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.deepOrangeAccent.withOpacity(0.8),
                  radius: 18.0 * scaler.widthScaleFactor,
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      fontSize: 25.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 13.0 * scaler.widthScaleFactor), // Add padding to left side for the text
                    child: Text(
                      content,
                      style: TextStyle(
                        fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
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
      ),
    );
  }
}
