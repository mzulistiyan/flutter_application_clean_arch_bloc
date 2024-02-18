import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../core.dart';

AssessmentResponse assessmentResponseFromJson(String str) => AssessmentResponse.fromJson(json.decode(str));

String assessmentResponseToJson(AssessmentResponse data) => json.encode(data.toJson());

class AssessmentResponse extends Equatable {
  List<AssessmentModel>? data;

  AssessmentResponse({
    this.data,
  });

  factory AssessmentResponse.fromJson(Map<String, dynamic> json) => AssessmentResponse(
        data: json["data"] == null ? [] : List<AssessmentModel>.from(json["data"]!.map((x) => AssessmentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [data];
}
