class Slot {
  final String id;
  final String doctorId;
  final int startUtc;
  final int endUtc;
  final String status;

  Slot({required this.id, required this.doctorId, required this.startUtc, required this.endUtc, required this.status});

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    id: json['id'] as String,
    doctorId: json['doctorId'] as String,
    startUtc: (json['startUtc'] as num).toInt(),
    endUtc: (json['endUtc'] as num).toInt(),
    status: json['status'] as String,
  );
}