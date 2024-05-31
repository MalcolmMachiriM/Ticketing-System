class Ticket {
  final String id;
  final String barcode;
  final bool checkedIn;

  Ticket({required this.id, required this.barcode, required this.checkedIn});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      barcode: json['barcode'],
      checkedIn: json['checkedIn'],
    );
  }
}
