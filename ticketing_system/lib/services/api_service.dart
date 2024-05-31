import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/match_event.dart';
import '../models/ticket.dart';

class ApiService {
  final String baseUrl = 'http://140.82.25.196:8057/swagger/index.html';
  final String tenant = 'root';
  final String username = 'admin@root.com';
  final String password = '123Pa\$\$word!';

  Future<User?> authenticate(
      String tenant, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/authenticate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'tenant': tenant, 'username': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data['token']);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to authenticate');
    }
  }

  Future<User?> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/api/user-profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<List<MatchEvent>> getMatchEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/api/match-events'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => MatchEvent.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load match events');
    }
  }

  Future<List<Ticket>> getTicketSales() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/api/ticket-sales'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Ticket.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load ticket sales');
    }
  }

  Future<List<Ticket>> getCheckedInTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/api/checked-in-tickets'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Ticket.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load checked-in tickets');
    }
  }

  Future<bool> validateBarcode(String barcode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/api/validate-barcode'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'barcode': barcode}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['valid'];
    } else {
      throw Exception('Failed to validate barcode');
    }
  }
}
