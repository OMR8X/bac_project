import 'dart:async';

import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:flutter/foundation.dart';

import 'exceptions.dart';

extension ErrorsMapper on Error {
  Exception get toException {
    switch (this) {
      default:
        return ServerException(message: toString());
    }
  }
}
