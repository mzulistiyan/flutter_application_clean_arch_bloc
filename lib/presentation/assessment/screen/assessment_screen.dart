import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
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
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;
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

                debugPrint('data: ${data.name}');

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
                                    '1/${state.result.question?.length}',
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
                        children: List.generate(
                          state.result.question?.length ?? 0,
                          (index) => questionWidget(
                            question: state.result.question?[index],
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
              Container(
                width: SizeConfig.safeBlockHorizontal * 40,
                child: SecoundaryButton(
                  text: 'Back',
                  onPressed: () {
                    if (_currentPageIndex > 0) {
                      _pageViewController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        _currentPageIndex--;
                      });
                    }
                  },
                ),
              ),
              const HorizontalSeparator(width: 2),
              Expanded(
                child: PrimaryButton(
                  text: 'Next',
                  onPressed: () {
                    if (_currentPageIndex < 2) {
                      _pageViewController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        _currentPageIndex++;
                      });
                    }
                  },
                ),
              )
            ],
          ),
        )
        // bottomNavigationBar: Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //   decoration: BoxDecoration(
        //     color: ColorConstant.blackColor,
        //     boxShadow: [
        //       BoxShadow(
        //         color: ColorConstant.blackColor.withOpacity(0.1),
        //         blurRadius: 10,
        //         offset: const Offset(0, -2),
        //       ),
        //     ],
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       IconButton(
        //         onPressed: () {
        //           if (_currentPageIndex > 0) {
        //             _pageViewController.previousPage(
        //               duration: const Duration(milliseconds: 300),
        //               curve: Curves.easeInOut,
        //             );
        //             setState(() {
        //               _currentPageIndex--;
        //             });
        //           }
        //         },
        //         icon: const Icon(Icons.arrow_back_ios),
        //       ),
        //       Text(
        //         '1/3',
        //         style: FontsGlobal.mediumTextStyle16,
        //       ),
        //       IconButton(
        //         onPressed: () {
        //           if (_currentPageIndex < 2) {
        //             _pageViewController.nextPage(
        //               duration: const Duration(milliseconds: 300),
        //               curve: Curves.easeInOut,
        //             );
        //             setState(() {
        //               _currentPageIndex++;
        //             });
        //           }
        //         },
        //         icon: const Icon(Icons.arrow_forward_ios),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }

  void showCustomDialog(BuildContext context) {
    final List<int> selectedNumbers = [1, 2, 3]; // Angka yang dipilih untuk warna yang berbeda

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
                    itemCount: 10, // Jumlah total item
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question?.section ?? '', style: FontsGlobal.mediumTextStyle16),
                  const VerticalSeparator(height: 0.5),
                  Text(
                    question?.questionName ?? '',
                    style: FontsGlobal.mediumTextStyle14,
                  ),
                ],
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
                const VerticalSeparator(height: 2),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: List.generate(
              question?.options?.length ?? 0,
              (index) => Row(
                children: [
                  Text(
                    question?.options?[index].optionName ?? '',
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
}
