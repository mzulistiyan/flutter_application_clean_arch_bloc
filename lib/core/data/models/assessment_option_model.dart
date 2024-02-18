// To parse this JSON data, do
//
//     final optionModel = optionModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import '../../core.dart';

OptionModel optionModelFromJson(String str) => OptionModel.fromJson(json.decode(str));

String optionModelToJson(OptionModel data) => json.encode(data.toJson());

class OptionModel extends Equatable {
  String? optionid;
  String? optionName;
  int? points;
  int? flag;

  OptionModel({
    this.optionid,
    this.optionName,
    this.points,
    this.flag,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
        optionid: json["optionid"],
        optionName: json["option_name"],
        points: json["points"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "optionid": optionid,
        "option_name": optionName,
        "points": points,
        "flag": flag,
      };

  @override
  List<Object?> get props => [optionid, optionName, points, flag];

  Option toEntity() {
    return Option(
      optionid: optionid,
      optionName: optionName,
      points: points,
      flag: flag,
    );
  }
}
