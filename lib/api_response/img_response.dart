
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'as http;
import 'package:wallcano/api_exception/exception.dart';

import '../model/image_data.dart';
class ApiResponse{
   Future<dynamic>? getApi(String url) async {
   try{
     final response = await http.get(
         Uri.parse(url),
         headers:
         {
           'Authorization': 'YBRqSvynyhqcKAUQNvw2oPstO6fRVp42J4URPWvPra1rhkq9mIMAVTyF'
         }
     );
     return apiResponse(response);
   } on SocketException{
     throw FetchDataException(mBody: 'Internet Error');
   }
  }

  dynamic apiResponse(http.Response res){
     switch(res.statusCode){
       case 200: var mResData=jsonDecode(res.body);
       return ImgData.fromJson(mResData);
       case 400:throw BadRequestException(mBody: res.body);
       case 401:
       case 403:
       case 407:throw UnAuthorisedException(mBody: res.body);
       case 500:
       default: throw ServerException(mBody: res.body);
     }
  }
}

