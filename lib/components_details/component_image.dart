import 'package:flutter/material.dart';
import 'package:nam_ip_museum/widgets.dart';
import 'package:photo_view/photo_view.dart';

class ComponentImage extends StatelessWidget {
  final String img;

  const ComponentImage({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Container(
        color: Colors.black,
        child: Center(
          child: PhotoView(
            imageProvider: AssetImage(img)
          ),
        ),
      ),
    );
  }
}
