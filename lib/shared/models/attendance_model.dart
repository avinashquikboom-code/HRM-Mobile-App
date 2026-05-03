class AttendanceRecord {
  final DateTime date;
  final String punchIn;
  final String? punchOut;
  final String status;

  AttendanceRecord({
    required this.date,
    required this.punchIn,
    this.punchOut,
    required this.status,
  });
}
