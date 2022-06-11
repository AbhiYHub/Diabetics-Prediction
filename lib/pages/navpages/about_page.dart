import 'package:diabetes_prediction/widgets/app_text.dart';
import 'package:diabetes_prediction/widgets/yt_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ignore: prefer_const_constructors
            YTVideoPlayer(),
            const SizedBox(height: 10),
            // AppLargeText(text: "Learn more about diabetes"),
            const SizedBox(height: 10),
            AppText(size: 18, text: "Know more at - ", color: Colors.black,),
            const SizedBox(height: 5),
            SelectableLinkify(
                onOpen: _onOpen,
                textScaleFactor: 1.2,
                text: "https://www.who.int/news-room/fact-sheets/detail/diabetes",
                style: const TextStyle(fontFamily: 'Poppins'),
              ),
          ],
        ),
      ),
    );
  }

   Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}
