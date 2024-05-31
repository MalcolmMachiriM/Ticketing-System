import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/match_events_screen.dart';
import 'screens/ticket_sales_screen.dart';
import 'screens/checked_in_tickets_screen.dart';
import 'screens/validate_barcode_screen.dart';

void main() {
  runApp(const TicketingApp());
}

class TicketingApp extends StatelessWidget {
  const TicketingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Ticketing System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return authProvider.user == null
                ? LoginScreen()
                : const DashboardScreen();
          },
        ),
        routes: {
          '/dashboard': (context) => const DashboardScreen(),
          '/match-events': (context) => const MatchEventsScreen(),
          '/ticket-sales': (context) => const TicketSalesScreen(),
          '/checked-in-tickets': (context) => const CheckedInTicketsScreen(),
          '/validate-barcode': (context) => ValidateBarcodeScreen(),
        },
      ),
    );
  }
}
