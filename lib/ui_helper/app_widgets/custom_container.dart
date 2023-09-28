import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppContainerForApiImg extends StatelessWidget {
  AppContainerForApiImg(
      {super.key,
      required this.height,
      required this.width,
       required  this.img,
      required this.radius,
      this.color
      });
  double height;
  double width;
  String img;
  double radius;
  Color?color;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(radius),
        ),
         );
  }
}
class AppContainerForOfflineImg extends StatelessWidget {
  AppContainerForOfflineImg(
      {super.key,
        required this.height,
        required this.width,
        required this.img,
        required this.radius,
        required this.catTitle,
        this.color,
      });
  double height;
  double width;
  String img;
  double radius;
  Color?color;
  String catTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
          child: Text(
            catTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25
            ),
          )),
    );
  }
}
