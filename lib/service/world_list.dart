import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WorldList{

  String? location;
  String? area;
  String? region;

  WorldList({
    this.location,
    this.area,
    this.region,
  });


  Future<List<WorldList>> fetchTimezones() async {
    final listUrl = Uri.parse('http://worldtimeapi.org/api/timezone');

    try {
      final response = await get(listUrl);

      if (response.statusCode == 200) {
        // Successfully fetched data
        final data = jsonDecode(response.body); // Parse JSON

        // 'data' is now a List<dynamic> containing timezone strings
        if (data is List) {
          final timezones = data.cast<String>().toList();
          // Convert timezone strings to WorldList objects
          final worldTimezones = timezones.map((timezone) {
            return WorldList(location: timezone, area: '', region: '');
          }).toList();
          return worldTimezones;
        } else {
          throw Exception('Data is not a List<dynamic>');
        }
      } else {
        // Handle errors here
        print('Failed to fetch data. Status code: ${response.statusCode}');
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other exceptions here
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}