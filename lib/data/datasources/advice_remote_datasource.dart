import 'dart:convert';
import 'package:flutter_clean_architecture/data/exceptions/exceptions.dart';
import 'package:flutter_clean_architecture/data/models/advice_model.dart';
import 'package:http/http.dart' as http;

abstract class AdviceRemoteDataSource {
  /// Requests a random advice from the API
  /// Returns [AdviceModel] if sucessful
  /// Throws a ServerExcaption if status code != 200
  Future<AdviceModel> getRandomAdviceFromApi();
}

final client = http.Client(); 

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final http.Client client; 
  AdviceRemoteDataSourceImpl({required this.client});

  
  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    
    final res = await client.get(
      Uri.parse("https://api.flutter-community.com/api/v1/advice"),
    );

    if (res.statusCode != 200) {
      throw ServerException();
    } else{
      final responseBody = jsonDecode(res.body);
      return AdviceModel.fromJson(responseBody);
    }
    
  }
}
