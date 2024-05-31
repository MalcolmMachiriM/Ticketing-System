import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class CheckedInTicketsScreen extends StatelessWidget {
  const CheckedInTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkedInTickets =
        Provider.of<AuthProvider>(context).checkedInTickets;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checked-in Tickets'),
      ),
      body: ListView.builder(
        itemCount: checkedInTickets.length,
        itemBuilder: (context, index) {
          final ticket = checkedInTickets[index];
          return ListTile(
            title: Text(ticket.barcode),
            subtitle: Text(ticket.checkedIn ? 'Checked In' : 'Not Checked In'),
          );
        },
      ),
    );
  }
}
