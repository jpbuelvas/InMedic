import 'package:flutter/foundation.dart';

class Doctor {
  String name;
  String specialism;
  double score;
  int numberOfReview;
  String phone;
  String description;
  bool favorite;

  Doctor({
    required this.name,
    required this.specialism,
    required this.score,
    required this.numberOfReview,
    required this.phone,
    required this.description,
    required this.favorite,
  });
}
