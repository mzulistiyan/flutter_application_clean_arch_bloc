import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../assessment.dart';
import '../../../common/common.dart';

class ListAssessmentScreen extends StatefulWidget {
  const ListAssessmentScreen({super.key});

  @override
  State<ListAssessmentScreen> createState() => _ListAssessmentScreenState();
}

class _ListAssessmentScreenState extends State<ListAssessmentScreen> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    context.read<ListAssessmentBloc>().add((ListAssessmentLoad()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman Assessment',
          style: FontsGlobal.mediumTextStyle16,
        ),
      ),
      body: BlocBuilder<ListAssessmentBloc, ListAssessmentState>(
        builder: (context, state) {
          if (state is ListAssessmentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ListAssessmentHasData) {
            return ListView.separated(
              separatorBuilder: (context, index) => const VerticalSeparator(height: 2),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final data = state.result[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssessmentScreen(
                          id: data.id ?? '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffD9D9D9)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AssetPath.assessmentIcon,
                          width: 50,
                          height: 50,
                        ),
                        const HorizontalSeparator(width: 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.name ?? '',
                                style: FontsGlobal.mediumTextStyle14,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const VerticalSeparator(height: 0.5),
                              Text(
                                'Created At: ${data.createdAt.toString().fullDateDMMMMY}',
                                style: FontsGlobal.mediumTextStyle12.copyWith(
                                  color: ColorConstant.greenColor,
                                ),
                              ),
                              VerticalSeparator(height: 0.5),
                              Text(
                                'last Download: -',
                                style: FontsGlobal.mediumTextStyle12.copyWith(
                                  color: ColorConstant.greenColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const HorizontalSeparator(width: 2),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.file_download_outlined),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ListAssessmentEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          } else if (state is ListAssessmentError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
