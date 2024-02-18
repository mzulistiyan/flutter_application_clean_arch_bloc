import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../assessment.dart';

class ListAssessmentScreen extends StatefulWidget {
  const ListAssessmentScreen({super.key});

  @override
  State<ListAssessmentScreen> createState() => _ListAssessmentScreenState();
}

class _ListAssessmentScreenState extends State<ListAssessmentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ListAssessmentBloc>().add((ListAssessmentLoad()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Assessment'),
      ),
      body: BlocBuilder<ListAssessmentBloc, ListAssessmentState>(
        builder: (context, state) {
          if (state is ListAssessmentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ListAssessmentHasData) {
            return ListView.builder(
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final data = state.result[index];
                return ListTile(
                  title: Text(data.name ?? ''),
                  subtitle: Text(data.description ?? ''),
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
