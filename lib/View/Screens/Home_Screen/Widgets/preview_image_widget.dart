import 'package:flutter/material.dart';

class PreviewImage extends StatelessWidget {
  String imageUrl;

  PreviewImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          child: Hero(
            tag: imageUrl,
            child: Image(
              image: NetworkImage(
                imageUrl,
              ),
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.contain,
              // height: 180,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
