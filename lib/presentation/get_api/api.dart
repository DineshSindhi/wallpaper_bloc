import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:wallpaper_bloc/presentation/get_api/api_key.dart';
import 'package:wallpaper_bloc/presentation/get_api/exception.dart';
import '../../data/model/data_model.dart';
class ApiHelper{
  getApiWallpaper({required String url}) async {
    var uri = Uri.parse(url);
    try{
      var data=await http.get(uri,headers: {'Authorization':'${GetApiKey.API_KEY}'});
      return returnException(data);
    }on SocketException catch(e){
      throw(NetworkError(errorMsg: 'No Internet'));
    }
  }
  returnException(http.Response response){
    switch(response.statusCode){
      case 200 :{
        var mData=jsonDecode(response.body);
        return mData;
      }
      case 400:BadRequestError(errorMsg: response.toString());
      case 401:UnauthorisedError(errorMsg: response.toString());
      case 404:InvalidInputError(errorMsg: response.toString());
      default:NetworkError(errorMsg: 'Error - ${response.toString()}');
    }
  }
}
//
//
//getCuratedWallpaper