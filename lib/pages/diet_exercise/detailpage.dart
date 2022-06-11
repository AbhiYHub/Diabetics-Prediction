import 'package:diabetes_prediction/widgets/app_text_large.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String img, name, description;
  const DetailsPage({Key? key, required this.img, required this.name, required this.description}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: const Color.fromARGB(255, 239, 236, 236),
                      height: MediaQuery.of(context).size.height * 0.45,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    // color: const Color.fromARGB(255, 233, 231, 231),
                    color: const Color.fromARGB(255, 239, 237, 237),
                    height: MediaQuery.of(context).size.height * 0.43,
                    padding: const EdgeInsets.only(bottom: 30),
                    alignment: Alignment.center,
                    child: Hero(tag: "hero${widget.name}", child: Image.asset("assets/img/" + widget.img, width: MediaQuery.of(context).size.width * 0.5, height: MediaQuery.of(context).size.width * 0.5)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AppLargeText(text: widget.name, size: 30, color: Colors.blue),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(widget.description, textAlign: TextAlign.justify, style: const TextStyle(color: Colors.black54, fontFamily: 'Poppins', fontSize: 13),),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    var firstStart = Offset(size.width / 5, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height - 50);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
