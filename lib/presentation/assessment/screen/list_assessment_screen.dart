import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:workmanager/workmanager.dart';
import '../../presentation.dart';
import '../assessment.dart';
import '../../../common/common.dart';
import '../../../core/core.dart';

class ListAssessmentScreen extends StatefulWidget {
  const ListAssessmentScreen({super.key});

  @override
  State<ListAssessmentScreen> createState() => _ListAssessmentScreenState();
}

class _ListAssessmentScreenState extends State<ListAssessmentScreen> {
  SaveAssessment? insertListAssessment;

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
        actions: [
          IconButton(
            onPressed: () {
              SecureStorageClient storageClient = SecureStorageClient.instance;
              storageClient.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
          // IconButton(
          //   onPressed: () async {
          //     // Box<CatModel> catBox = await HiveBoxHelperClass.openCatBox(boxName: 'cats');
          //     // var catModel = CatModel('foo', "4", true); //creating object
          //     // await catBox.put(catModel.name, catModel); //putting object into hive box
          //     // CatModel? catModelGet = catBox.get('foo');
          //     // print(catModelGet?.name ?? '');
          //     Box<QuestionHiveModel> catBox = await Hive.openBox('questions');
          //     var questionModel = QuestionHiveModel(
          //       questionid: '1',
          //       questionName: 'Test Question',
          //       section: 'Section Test',
          //       type: 'Type Test',
          //       number: 'Number Test',
          //       scoring: true,
          //       options: [
          //         OptionHiveModel(
          //           optionid: '1',
          //           optionName: 'Option Test',
          //           flag: 1,
          //           points: 1,
          //         ),
          //       ],
          //     ); //creating object
          //     // await catBox.put(questionModel.questionid, questionModel); //putting object into hive box
          //     QuestionHiveModel? questionModelGet = catBox.get('1');
          //     print(questionModelGet?.options![0].optionName ?? '');
          //   },
          //   icon: const Icon(Icons.file_download_outlined),
          // ),
          // IconButton(
          //   onPressed: () async {
          //     Box<BodyReqHiveAssesment> assessmentBox = await Hive.openBox<BodyReqHiveAssesment>('AnswerAssessmentLocal');
          //     // var bodyReq = BodyReqHiveAssesment(
          //     //   assessmentId: '1',
          //     //   answers: [
          //     //     AnswerHive(
          //     //       questionId: '1',
          //     //       answer: 'Answer Test',
          //     //     ),
          //     //   ],
          //     // ); //creating object
          //     // await assessmentBox.add(bodyReq); //putting object into hive box
          //     await assessmentBox.clear();

          //     print(assessmentBox.values.toList());

          //     // bool isExists = catBox.containsKey('foo');

          //     // bool isEmpty = catBox.isEmpty;

          //     // debugPrint('isExists: $isExists');
          //     // debugPrint('isBoxNotEmpty: $isEmpty');

          //     // // CatModel? catModel = catBox.getAt(0); //get by index
          //     // List<CatModel> catModelList = catBox.values.toList(); //get all items in list

          //     // // print(catModel?.name ?? '');
          //     // print(catModelList[0].name);
          //   },
          //   icon: const Icon(Icons.get_app_outlined),
          // ),
          // IconButton(
          //   onPressed: () async {
          //     // Box<CatModel> catBox = await HiveBoxHelperClass.openCatBox(boxName: 'cats');

          //     // catBox.clear();
          //   },
          //   icon: Icon(
          //     Icons.delete,
          //   ),
          // )
        ],
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
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ListAssessmentBloc>().add(ListAssessmentRefresh());
              },
              child: buildAssessment(context),
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

  ListView buildAssessment(BuildContext context) {
    final bloc = BlocProvider.of<ListAssessmentBloc>(context);

    return ListView.separated(
      separatorBuilder: (context, index) => const VerticalSeparator(height: 2),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      itemCount: bloc.assessments.length,
      itemBuilder: (context, index) {
        if (index == bloc.assessments.length - bloc.nextPageTrigger) {
          bloc.add(CheckIfNeedMoreDataEvent(index: index));
        }

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssessmentScreen(
                  id: bloc.assessments[index].id ?? '',
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
                        "${bloc.assessments[index].id ?? ''} NO : ${index + 1}",
                        style: FontsGlobal.mediumTextStyle14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const VerticalSeparator(height: 0.5),
                      Text(
                        'Created At: ${bloc.assessments[index].createdAt.toString().fullDateDMMMMY}',
                        style: FontsGlobal.mediumTextStyle12.copyWith(
                          color: ColorConstant.greenColor,
                        ),
                      ),
                      VerticalSeparator(height: 0.5),
                      Text(
                        'Last Download: ${bloc.assessments[index].downloadedAt?.toString().fullDateDMMMMY ?? '-'}',
                        style: FontsGlobal.mediumTextStyle12.copyWith(
                          color: ColorConstant.greenColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const HorizontalSeparator(width: 2),
                BlocConsumer<AssessmentDetailBloc, AssessmentDetailState>(
                  listener: (context, state) {
                    if (state is AssessmentDetailHasData) {
                      List<QuestionHiveModel> questionHiveModel = state.result.question!
                          .map((item) => QuestionHiveModel(
                                questionid: item.questionid,
                                questionName: item.questionName,
                                section: item.section,
                                type: item.type,
                                number: item.number,
                                scoring: item.scoring,
                                options: item.options
                                    ?.map((e) => OptionHiveModel(
                                          optionid: e.optionid,
                                          optionName: e.optionName,
                                          flag: e.flag,
                                          points: e.points,
                                        ))
                                    .toList(),
                              ))
                          .toList();

                      debugPrint('questionHiveModel: $questionHiveModel');
                      // context.read<InsertAssessmentLocalBloc>().add(
                      //       InsertAssessmentLocal(
                      //         AssessmentHiveModel(
                      //           id: bloc.assesments[index].id,
                      //           name: bloc.assesments[index].name,
                      //           assessmentDate: bloc.assesments[index].assessmentDate,
                      //           description: bloc.assesments[index].description,
                      //           type: bloc.assesments[index].type,
                      //           createdAt: bloc.assesments[index].createdAt,
                      //           lastDownloaded: DateTime.now(),
                      //         ),
                      //       ),
                      //     );
                      context.read<InsertDetailAssessmentLocalBloc>().add(
                            InsertDetailAssessmentLocal(
                              AssessmentDetailResponseHive(
                                id: state.result.id,
                                name: state.result.name,
                                question: questionHiveModel,
                              ),
                            ),
                          );
                    }
                  },
                  builder: (context, stateAssessmentDetailBloc) {
                    return BlocConsumer<InsertAssessmentLocalBloc, InsertAssessmentLocalState>(
                      listener: (context, state) {},
                      builder: (context, stateInsertAssessmentLocalBloc) {
                        return Column(
                          children: [
                            IconButton(
                              onPressed: () async {
                                context.read<AssessmentDetailBloc>().add(FecthAssessmentDetail(id: bloc.assessments[index].id ?? ''));
                                context.read<InsertAssessmentLocalBloc>().add(
                                      InsertAssessmentLocal(
                                        AssessmentHiveModel(
                                          id: bloc.assessments[index].id,
                                          name: bloc.assessments[index].name,
                                          assessmentDate: bloc.assessments[index].assessmentDate,
                                          description: bloc.assessments[index].description,
                                          type: bloc.assessments[index].type,
                                          createdAt: bloc.assessments[index].createdAt,
                                          lastDownloaded: DateTime.now(),
                                        ),
                                      ),
                                    );
                              },
                              icon: const Icon(Icons.file_download_outlined),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
