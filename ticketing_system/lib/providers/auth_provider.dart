import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user.dart';
import '../models/match_event.dart';
import '../models/ticket.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  List<MatchEvent> _matchEvents = [];
  List<Ticket> _ticketSales = [];
  List<Ticket> _checkedInTickets = [];

  User? get user => _user;
  List<MatchEvent> get matchEvents => _matchEvents;
  List<Ticket> get ticketSales => _ticketSales;
  List<Ticket> get checkedInTickets => _checkedInTickets;

  Future<bool> login(String email, String password) async {
    try {
      _user = await ApiService().authenticate('root', email, password);
      if (_user != null) {
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Login failed: $e');
      return false;
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  Future<void> loadUserProfile() async {
    if (_user != null) {
      _user = await ApiService().getUserProfile();
      notifyListeners();
    }
  }

  Future<void> loadMatchEvents() async {
    if (_user != null) {
      _matchEvents = await ApiService().getMatchEvents();
      notifyListeners();
    }
  }

  Future<void> loadTicketSales() async {
    if (_user != null) {
      _ticketSales = await ApiService().getTicketSales();
      notifyListeners();
    }
  }

  Future<void> loadCheckedInTickets() async {
    if (_user != null) {
      _checkedInTickets = await ApiService().getCheckedInTickets();
      notifyListeners();
    }
  }

  Future<bool> validateBarcode(String barcode) async {
    if (_user != null) {
      return await ApiService().validateBarcode(barcode);
    }
    return false;
  }
}
