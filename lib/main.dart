import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Image Picker from Gallery"),
            backgroundColor: const Color.fromARGB(255, 0, 0, 0)),
        body: Center(
          child: profileImage(),
        ));
  }

  Widget profileImage() {
    return Center(
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent,
            border: Border.all(
                color: Color.fromARGB(255, 3, 3, 3),
                width: 5.0,
                style: BorderStyle.solid),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: image != null
                  ? FileImage(File(image!.path))
                  : const AssetImage('assets/profile.jpg') as ImageProvider,
            ),
          ),
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          alignment: Alignment.topCenter,
          height: 220,
          width: 220,
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: InkWell(
            onTap: () async {
              image = await picker.pickImage(source: ImageSource.gallery);
              setState(() {});
            },
            child: buildEditIcon(),
          ),
        ),
      ]),
    );
  }

  Widget buildEditIcon() => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: const Color.fromARGB(255, 0, 0, 0),
          all: 8,
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
