
import 'package:flutter/material.dart';

class AppConst{
  static const String base='https://api.pexels.com/v1/';
  static const String curatedImagesLink='${base}curated';
  static const String searchQueryLink='${base}search';
  static const List<Map<String,dynamic>> listOfCategory=[
    {  'categoryName':'Nature',
      'img':'assets/img/natural.jpg'
    },
    {  'categoryName':'Animals',
      'img':'assets/img/Animals.jpg'
    },
    {  'categoryName':'Cars',
      'img':'assets/img/cars.jpg'
    },
    {  'categoryName':'City',
      'img':'assets/img/city.jpg'
    },
    {  'categoryName':'General',
      'img':'assets/img/general.jpg'
    },
    {  "categoryName":'Abstract',
      'img':'assets/img/abstract.jpg'
    },
  ];
  static const List<Map<String,dynamic>> listOfColors=[
    {
      'colorName':'red',
      'colorValue':Colors.red
    },

    {
      'colorName':'blue',
      'colorValue':Colors.blue
    },

    {
      'colorName':'green',
      'colorValue':Colors.green
    },
    {
      'colorName':'purple',
      'colorValue':Colors.purple
    },

    {
      'colorName':'black',
      'colorValue':Colors.black
    },
    {
      'colorName':'yellow',
      'colorValue':Colors.yellow
    },

    {
      'colorName':'pink',
      'colorValue':Colors.pink
    },

    {
      'colorName':'grey',
      'colorValue':Colors.grey
    },
    {
      'colorName':'brown',
      'colorValue': Color(0xff964B00)
    }
  ];
}