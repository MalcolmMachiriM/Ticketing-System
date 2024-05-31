import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class TicketSalesScreen extends StatelessWidget {
  const TicketSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ticketSales = Provider.of<AuthProvider>(context).ticketSales;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Sales'),
      ),
      body: ListView.builder(
        itemCount: ticketSales.length,
        itemBuilder: (context, index) {
          final ticket = ticketSales[index];
          return ListTile(
            title: Text(ticket.barcode),
            subtitle: Text(ticket.checkedIn ? 'Checked In' : 'Not Checked In'),
          );
        },
      ),
    );
  }
}
