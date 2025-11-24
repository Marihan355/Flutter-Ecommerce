import 'package:dio/dio.dart';   //http client for making API calls
import 'package:pretty_dio_logger/pretty_dio_logger.dart';  //help me print every req and res in console in clean format. useful for debugging

class ApiService {
final Dio dio;     //final because it can't be changed after initialization
ApiService({Dio? client}) :dio = client ?? Dio() {  //constructor. if user sends a client, use it. if not, create new Dio instance
 dio.options.baseUrl= 'https://dummyjson.com/';     //my base url so i don't have to write it every time
 dio.options.connectTimeout= const Duration(seconds: 15);  //how long dio waits to connect to the server before it gives up
 dio.options.receiveTimeout= const Duration(seconds: 15);  // how long dio waits to receive data before it gives up
 dio.interceptors.add(PrettyDioLogger(  //add the logger that tells me every req and res in console
  requestHeader: true,  
   requestBody: true,
  responseBody: true,
   responseHeader: true,
   compact: true,  //make the printed data easier to read
  ));
}

Future<Response> get(String path, {Map<String, dynamic>? query}) async {  //Future because api calls taks time and it's asyn
  return dio.get(path, queryParameters: query);                           //get got a parameter which is the path ex: "products"
 }                                                                        //the 2ed par is named query: optional ? it's a map, key are Strings, va;ue are dynamic (can be any type). this par can be null. ex quer{"limit": 10, "skip":5,}
}                                                         //the return is the exact request
  
