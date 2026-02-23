import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/features.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => injector(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Minhas conversas',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MultiplierColors.neutral_400,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout_outlined,
                color: MultiplierColors.neutral_500,
              ),
            ),
          ],
        ),
        body: DashboardContent(),
        floatingActionButton: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: MultiplierColors.primary,
              child: Icon(Icons.speaker_notes, size: 30, color: Colors.white),
              onPressed: () async {
                //final String? returnedResult =
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );

                // if (returnedResult != null && returnedResult.isNotEmpty) {
                //   searchController.value = TextEditingValue(
                //     text: returnedResult,
                //   );
                //   await BlocProvider.of<SearchCubit>(
                //     context,
                //   ).fetchGithubUsers(returnedResult);
                // }
              },
            );
          },
        ),
      ),
    );
  }
}
