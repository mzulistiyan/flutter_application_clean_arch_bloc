import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../core.dart';

abstract class AssessmentRemoteDataSource {
  Future<List<AssessmentModel>> getAssessment();
  Future<AssessmentDetailResponse> getAssessmentDetail(String id);
}

class AssessmentRemoteDataSourceImpl implements AssessmentRemoteDataSource {
  final DioClient dioClient;

  AssessmentRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<AssessmentModel>> getAssessment() async {
    final response = await dioClient.get(
      url: UrlConstant.assessment,
      headers: {
        'Content-Type': 'application/json',
        'Cookie':
            'token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlX2lkIjoiNCIsInBlcm1pc3Npb25zIjpbMTMwLDEzMywxMzUsMTM4LDE0MiwxNTQsMSwyLDMsNCw1LDYsOSwxMSwxMiwxMywxNywxMCw4XSwiZXhwIjoxNzA4MzM2NjcxLCJpc3MiOiJTWU4xMCJ9.cFZnkV_not_4VTjvmKCdCJhewZe10cKlilovp_hLkUw',
      },
      queryParams: {
        'page': 1,
        'limit': 10,
      },
    );

    if (response.statusCode == 200) {
      return AssessmentResponse.fromJson(response.data).data ?? [];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AssessmentDetailResponse> getAssessmentDetail(String id) async {
    final response = await dioClient.get(
      url: '${UrlConstant.assessmentDetail}/$id',
      headers: {
        'Content-Type': 'application/json',
        'Cookie':
            'token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlX2lkIjoiNCIsInBlcm1pc3Npb25zIjpbMTMwLDEzMywxMzUsMTM4LDE0MiwxNTQsMSwyLDMsNCw1LDYsOSwxMSwxMiwxMywxNywxMCw4XSwiZXhwIjoxNzA4MzM2NjcxLCJpc3MiOiJTWU4xMCJ9.cFZnkV_not_4VTjvmKCdCJhewZe10cKlilovp_hLkUw',
      },
    );

    if (response.statusCode == 200) {
      return AssessmentDetailResponse.fromJson(response.data['data']);
    } else {
      throw ServerException();
    }
  }
}
