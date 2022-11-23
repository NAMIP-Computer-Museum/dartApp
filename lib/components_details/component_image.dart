import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../utils/widgets.dart';

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
            imageProvider: AssetImage(img),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 3.0,
          ),
        ),
      ),
    );
  }
}
