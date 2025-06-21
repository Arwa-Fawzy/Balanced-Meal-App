import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

int? calculateCalories(
  String? gender,
  int? weight,
  int? height,
  int? age,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (gender == null || weight == null || height == null || age == null) {
    return null;
  }

  if (gender.toLowerCase() == 'female') {
    return (655.1 + 9.56 * weight + 1.85 * height - 4.67 * age).round();
  } else {
    return (666.47 + 13.75 * weight + 5 * height - 6.75 * age).round();
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
