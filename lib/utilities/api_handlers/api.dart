import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zurichat/models/api_response.dart';
import 'package:zurichat/utilities/failures.dart';

abstract class Api {
  /// THIS IS THE API ABSTRACT CLASS FOR ZURI CHAT MOBILE
  /// THE PURPOSE OF WRITING THIS FILE IS TO AID THE USE OF SERVICES
  /// ALSO TO HIDE THE SERVICES USED, FROM THE USER.
  /// THESE SERVICES ARE TO BE USED CAREFULLY AND SMOOTHLY
  /// AS IT IS DEFINED HEREIN.
  ///
  ///
  /// KINDLY NOTE THAT BEFORE ANY EDIT CAN BE MADE, IT MUST BE
  /// AUTORIZED BY THE LEAD DEVELOPER WHO IS MONITORING THIS PROJECT
  ///
  ///
  /// BELOW ARE SERVICES USED...
  /// -----------------------------------------------------------------------
  ///
  /// OTHER SERVICES CAN BE ADDED AS NEED BE - FOR CONSUMPTION.
  /// AS YOU REGISTER A SERVICE, KINDLY WRITE A BRIEF ABOUT THE
  /// SERVICE AND WHAT IT OFFERS.
  ///
  /// -----------------------------------------------------------------------


  // THE SERVICE TO UPDATE IMAGE OF A USER
  Future uploadImage(
    File image, {
    required String token,
    required String pluginId,
  });


  /// THE SERVICE TO GET THE LIST OF ACTIVE DMs
  Future<List> getActiveDms(String orgId, token);


  /// THE SERVICE TO GET THEMES ALL THROUGH THE MOBILE APP
  List<ThemeData> getThemes();

  /// THE SERVICE TO SEND GET REQUEST
  sendGetRequest(endpoint);

  /// POSTS REQUEST SERVICE
  sendPostRequest(body, endpoint);

  /// PATCH REQUEST SERVICE
  sendPatchRequest(body, endpoint, userId);

  /// ERROR HANDLING SERVICE
  Failure handleApiError(DioError e);
  
  // Future uploadImage{
  //   File image,(
  //     {required String token,
  //     required String pluginId}
  //   );
  // }

  /// A SERVICE TO SEND PATCH REQUEST TO THE ENDPOINT
  Future<ApiResponse?> patch(String path,
      {Map<String, dynamic>? body, String? token});

  Future<ApiResponse?> delete(String path,
      {Map<String, dynamic>? body, String? token});
}
