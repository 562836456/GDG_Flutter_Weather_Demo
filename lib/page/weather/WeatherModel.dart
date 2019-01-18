import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:gdg_weather/page/weather/WeatherData.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class WeatherModel extends Model{
  String cityName;
  WeatherData weather = WeatherData.empty();

  WeatherModel(this.cityName);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    print("WeatherModel addListener");
    fetchWeather();
  }

  void fetchWeather() async{
    print("fetchWeather:"+this.cityName);
    final response = await http.get('https://free-api.heweather.com/s6/weather/now?location='+this.cityName+'&key=ebb698e9bb6844199e6fd23cbb9a77c5');
    if(response.statusCode == 200){
      weather = WeatherData.fromJson(json.decode(response.body));
    }else{
      weather = WeatherData.empty();
    }

    notifyListeners();
  }
}