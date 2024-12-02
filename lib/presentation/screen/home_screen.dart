import 'package:cat_facts/presentation/bloc/cat_facts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Facts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HistoryScreen()),
            ),
          ),
        ],
      ),
      body: BlocBuilder<CatFactsBloc, CatFactsState>(
        builder: (context, state) {
          if (state is CatFactsInitial) {
            return const Center(child: Text('Press button'));
          }
          if (state is CatFactsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CatFactsLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  state.imageUrl,
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return const CircularProgressIndicator();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    state.fact.text,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(state.fact.createdAt),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            );
          }
          if (state is CatFactsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CatFactsBloc>().add(LoadNewFact()),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
