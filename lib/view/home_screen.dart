import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/ideas_cubit.dart';
import '../cubits/ideas_state.dart';
import '../widgets/add_dialog.dart';
import '../widgets/idea_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  Future<void> _refreshData() async {
    BlocProvider.of<IdeasCubit>(context).fetchIdeas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          'Emerging Ideas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        child: BlocBuilder<IdeasCubit, IdeasState>(
          builder: (context, state) {
            if (state is IdeasLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is IdeasLoaded) {
              return IdeaList(ideas: state.ideas);
            } else if (state is IdeasError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'No ideas found',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: BlocProvider.of<IdeasCubit>(context),
                child: AddDialog(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
