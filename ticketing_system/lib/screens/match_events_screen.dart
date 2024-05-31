// TODO Implement this library.import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class MatchEventsScreen extends StatelessWidget {
  const MatchEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final matchEvents = Provider.of<AuthProvider>(context).matchEvents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Events'),
      ),
      body: ListView.builder(
        itemCount: matchEvents.length,
        itemBuilder: (context, index) {
          final event = matchEvents[index];
          return ListTile(
            title: Text(event.name),
            subtitle: Text(event.date.toLocal().toString()),
          );
        },
      ),
    );
  }
}
