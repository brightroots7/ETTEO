import 'dart:convert';

import 'package:flutter/services.dart';

/// Error Messages
class ErrorMessages {
  static ErrorMessages _singleton = new ErrorMessages._internal();

  factory ErrorMessages() {
    return _singleton;
  }

  ErrorMessages._internal();

  Map<String, dynamic> errorMessages = Map<String, dynamic>();

  /// Load error messages from asset error_messages json
  Future<ErrorMessages> loadDefaultErrorMessagesFromAsset(
      String errorMessageJson) async {
    
    String errorMessageFile = await rootBundle.loadString(errorMessageJson);
    Map<String, dynamic> map = json.decode(errorMessageFile);
    errorMessages.addAll(map);
    return _singleton;
  }

  dynamic get(String key) => errorMessages[key];
}

