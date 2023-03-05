import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundImage extends StatelessWidget {
   BackgroundImage({super.key, required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset('assets/images/background.svg',
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           ),
           child
        ],
      ),
    );
  }
}