// ignore_for_file: non_constant_identifier_names

class ExpanceType {
  int? id;
  String? expance_type;
  ExpanceType({
    this.id,
    required this.expance_type,
  });
  factory ExpanceType.fromMap(Map<String, dynamic> row) {
    return ExpanceType(
      id: row['id'],
      expance_type: row['expance_type'],
    );
  }
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'expance_type': expance_type,
    };
  }
}
