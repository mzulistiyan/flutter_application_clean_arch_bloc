import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import '../../presentation.dart';
import '../../../common/common.dart';

import '../../../core/core.dart';

class AssessmentScreen extends StatefulWidget {
  String id;
  AssessmentScreen({super.key, required this.id});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> with SingleTickerProviderStateMixin {
  //Pageview
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;
  int lengthPage = 0;

  //Answer
  String? _selectedOptionId; // Variabel untuk menyimpan ID opsi yang dipilih
  List<String> selectedOptionIds = [];
  List<Answer>? answerList = [];
  Map<String, String> selectedOptionIdByQuestion = {}; // Untuk menyimpan opsi radio yang dipilih berdasarkan questionId
  Map<String, List<String>> selectedOptionsForCheckboxes = {}; // Untuk menyimpan opsi checkbox yang dipilih
  final List<int> selectedNumbers = []; // Angka yang dipilih untuk warna yang berbeda

  String labelButton = 'Next';

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(
      initialPage: 0,
    );
    _tabController = TabController(
      length: 3,
      vsync: this,
    );

    debugPrint('id: ${widget.id}');
    context.read<AssessmentDetailBloc>().add(FecthAssessmentDetail(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AssessmentDetailBloc, AssessmentDetailState>(
          bloc: context.read<AssessmentDetailBloc>(),
          builder: (context, state) {
            if (state is AssessmentDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AssessmentDetailHasData) {
              final data = state.result;
              lengthPage = data.question?.length ?? 0;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorConstant.primaryColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '45 Second Left',
                            style: FontsGlobal.mediumTextStyle14.copyWith(
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => showCustomDialog(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: ColorConstant.blackColor,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.format_list_bulleted,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const HorizontalSeparator(width: 1),
                                Text(
                                  '${_currentPageIndex + 1}/${data.question?.length}',
                                  style: FontsGlobal.mediumTextStyle14.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalSeparator(height: 2),
                  Expanded(
                    child: PageView(
                      controller: _pageViewController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageIndex = index;
                          labelButton = index == (data.question?.length ?? 1) - 1 ? 'Submit' : 'Next';
                        });
                      },
                      children: List.generate(
                        data.question?.length ?? 0,
                        (index) => questionWidget(
                          question: data.question?[index],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is AssessmentDetailError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Error'));
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * 40,
              child: SecoundaryButton(
                text: 'Back',
                onPressed: () {
                  if (_currentPageIndex > 0) {
                    _pageViewController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                  }
                },
              ),
            ),
            const HorizontalSeparator(width: 2),
            Expanded(
              child: BlocConsumer<AssessmentPostBloc, AssessmentPostState>(
                listener: (context, state) {
                  debugPrint('state AssessmentPostBloc: $state');
                  if (state is AssessmentPostSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message,
                          style: FontsGlobal.mediumTextStyle14,
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    text: labelButton, // Gunakan variabel labelButton yang telah diperbarui
                    onPressed: () {
                      //next page
                      if (_currentPageIndex + 1 == lengthPage) {
                        //check answer list is empty
                        if (answerList?.isEmpty ?? true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Silahkan Isi Minimal 1 Jawaban',
                                style: FontsGlobal.mediumTextStyle14,
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          //submit answer
                          final bodyReqAssesment = BodyReqAssesment(
                            assessmentId: widget.id,
                            answers: answerList,
                          );
                          context.read<AssessmentPostBloc>().add(PostAssessmentAnswer(bodyReqAssesment: bodyReqAssesment));
                        }
                      } else {
                        _pageViewController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return Align(
          alignment: Alignment.topCenter, // Menempel pada bagian atas layar
          child: Container(
            padding: const EdgeInsets.only(top: 50),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2, // Setengah dari tinggi layar
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Survei Question',
                    style: FontsGlobal.mediumTextStyle18.copyWith(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                Divider(
                  color: ColorConstant.blackColor,
                  thickness: 0.1,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // Jumlah item dalam satu baris
                    ),
                    itemCount: lengthPage,
                    itemBuilder: (BuildContext context, int index) {
                      bool isSelected = selectedNumbers.contains(index + 1);
                      return GestureDetector(
                        onTap: () {
                          //change page
                          _pageViewController.jumpToPage(index);
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected ? ColorConstant.primaryColor : Colors.white, // Warna latar berdasarkan seleksi
                            border: Border.all(color: Colors.black, width: 0.5), // Batas kotak
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}', // Nomor kotak
                              style: FontsGlobal.mediumTextStyle14.copyWith(
                                color: isSelected ? Colors.white : Colors.black, // Warna teks berdasarkan seleksi
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget questionWidget({
    Question? question,
  }) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.safeBlockVertical * 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(question?.section ?? '', style: FontsGlobal.boldTextStyle16),
                    const VerticalSeparator(height: 0.5),
                    Text(
                      question?.questionName ?? '',
                      style: FontsGlobal.mediumTextStyle14,
                    ),
                  ],
                ),
              ),
            ),
            const VerticalSeparator(height: 2),
            Container(
              width: double.infinity,
              height: SizeConfig.safeBlockVertical * 2,
              color: ColorConstant.secondaryColor,
            ),
            const VerticalSeparator(height: 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Answer', style: FontsGlobal.mediumTextStyle16),
                ),
                Divider(
                  color: ColorConstant.blackColor,
                  thickness: 0.1,
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: List.generate(
              question?.options?.length ?? 0,
              (index) => Row(
                children: [
                  if (question!.type == 'multiple_choice') ...[
                    Radio(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: question.options?[index].optionid,
                      groupValue: _selectedOptionId, // Variabel untuk menyimpan ID opsi yang dipilih
                      onChanged: (value) {
                        debugPrint('value: $value');
                        setState(() {
                          _selectedOptionId = value as String;
                          _updateAnswerListForRadio(question.questionid ?? '', value);
                          selectedNumbers.add(_currentPageIndex + 1);
                        });
                      },
                    ),
                  ] else ...[
                    GFCheckbox(
                      size: 20,
                      type: GFCheckboxType.custom,
                      inactiveBorderColor: Colors.grey,
                      activeBorderColor: ColorConstant.primaryColor,
                      activeBgColor: ColorConstant.primaryColor,
                      customBgColor: ColorConstant.primaryColor,
                      inactiveBgColor: Colors.white,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedOptionIds.add(question.options?[index].optionid ?? '');
                          } else {
                            selectedOptionIds.remove(question.options?[index].optionid);
                          }
                          _updateAnswerListForCheckbox(question.questionid ?? '', question.options?[index].optionid ?? '', value!);
                          selectedNumbers.add(_currentPageIndex + 1);
                        });
                      },
                      value: selectedOptionIds.contains(question.options?[index].optionid),
                      inactiveIcon: null,
                    ),
                  ],
                  Text(
                    question.options?[index].optionName ?? '',
                    style: FontsGlobal.mediumTextStyle16,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget customCheckbox({bool? value, Function(bool?)? onChanged}) {
    return InkWell(
      onTap: () => onChanged?.call(!value!),
      child: Container(
        decoration: BoxDecoration(
          color: value == true ? Colors.blue : Colors.transparent, // Warna latar biru jika terpilih
          border: Border.all(
            color: value == true ? Colors.blue : Colors.grey, // Border biru jika terpilih, abu-abu jika tidak
            width: 2, // Lebar border
          ),
          shape: BoxShape.rectangle, // Bentuk kotak
        ),
        width: 24, // Lebar kotak (sesuaikan sesuai kebutuhan)
        height: 24, // Tinggi kotak (sesuaikan sesuai kebutuhan)
        child: value == true
            ? const Icon(
                Icons.check, // Icon centang
                size: 24, // Ukuran icon
                color: Colors.white, // Warna icon
              )
            : null, // Jika tidak terpilih, tidak menampilkan apa-apa
      ),
    );
  }

  void _updateAnswerListForRadio(String questionId, String optionId) {
    selectedOptionIdByQuestion[questionId] = optionId; // Simpan atau perbarui opsi yang dipilih
    // Filter answerList untuk menghapus jawaban sebelumnya untuk questionId ini
    answerList?.removeWhere((answer) => answer.questionId == questionId);
    // Tambahkan jawaban baru
    answerList?.add(Answer(questionId: questionId, answer: optionId));
  }

  void _updateAnswerListForCheckbox(String questionId, String optionId, bool isSelected) {
    final selectedOptions = selectedOptionsForCheckboxes.putIfAbsent(questionId, () => []);
    if (isSelected) {
      selectedOptions.add(optionId);
    } else {
      selectedOptions.remove(optionId);
    }
    selectedOptionsForCheckboxes[questionId] = selectedOptions;
    // Filter answerList untuk menghapus jawaban sebelumnya untuk questionId ini
    answerList?.removeWhere((answer) => answer.questionId == questionId);
    // Tambahkan jawaban baru dengan optionId yang dipilih
    if (selectedOptions.isNotEmpty) {
      answerList?.add(Answer(questionId: questionId, answer: selectedOptions.join(',')));
    }
  }
}
