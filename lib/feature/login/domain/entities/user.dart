import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  final String name;
  final String token;

  User({
    @required this.name,
    @required this.token,
  }) : super([
          token,
          name,
        ]);
}
