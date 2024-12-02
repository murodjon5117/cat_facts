import 'package:cat_facts/domain/model/cat_fact.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fact History')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<CatFact>('facts').listenable(),
        builder: (context, Box<CatFact> box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final fact = box.getAt(index);
              return ListTile(
                title: Text(fact?.text ?? ''),
                subtitle: Text(
                  DateFormat.yMMMd().format(fact?.createdAt ?? DateTime.now()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
