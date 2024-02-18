import 'package:equatable/equatable.dart';

class Option extends Equatable {
  final String? optionid;
  final String? optionName;
  final int? points;
  final int? flag;

  const Option({
    this.optionid,
    this.optionName,
    this.points,
    this.flag,
  });

  @override
  List<Object?> get props => [optionid, optionName, points, flag];
}
