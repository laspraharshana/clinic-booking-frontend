class Doctor {
  final String id;
  final String name;
  final String? specialty;
  final String? clinicName;
  final String? address;
  final String? bio;
  final int? yearsExp;
  final int? patientsCount;
  final double? rating;
  final int? consultationFee;
  final String? photoUrl;
  final int? nextAvailableStartUtc; // epoch ms

  Doctor({
    required this.id,
    required this.name,
    this.specialty,
    this.clinicName,
    this.address,
    this.bio,
    this.yearsExp,
    this.patientsCount,
    this.rating,
    this.consultationFee,
    this.photoUrl,
    this.nextAvailableStartUtc,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    final ratingNum = json['rating'] as num?;
    final feeNum = json['consultationFee'] as num?;
    final nextMs = json['nextAvailableStartUtc'] as num?;
    final yearsNum = json['yearsExp'] as num?;
    final patientsNum = json['patientsCount'] as num?;

    return Doctor(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Doctor',
      specialty: json['specialty'] as String?,
      clinicName: json['clinicName'] as String?,
      address: json['address'] as String?,
      bio: json['bio'] as String?,
      yearsExp: yearsNum?.toInt(),
      patientsCount: patientsNum?.toInt(),
      rating: ratingNum?.toDouble(),
      consultationFee: feeNum?.toInt(),
      photoUrl: json['photoUrl'] as String?,
      nextAvailableStartUtc: nextMs?.toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'specialty': specialty,
    'clinicName': clinicName,
    'address': address,
    'bio': bio,
    'yearsExp': yearsExp,
    'patientsCount': patientsCount,
    'rating': rating,
    'consultationFee': consultationFee,
    'photoUrl': photoUrl,
    'nextAvailableStartUtc': nextAvailableStartUtc,
  };
}