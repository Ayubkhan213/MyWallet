// ignore_for_file: non_constant_identifier_names

class ExpanceModel {
  int? id;
  int? user_id;
  String? title;
  int? expance_type;
  int? expance;
  String date;
  String? source;
  int? filter_date;
  ExpanceModel({
    this.id,
    required this.user_id,
    required this.title,
    required this.expance_type,
    required this.expance,
    required this.date,
    required this.source,
    required this.filter_date,
  });
  factory ExpanceModel.fromMap(Map<String, dynamic> row) {
    return ExpanceModel(
      id: row['id'],
      user_id: row['user_id'],
      title: row['title'],
      expance_type: row['expance_type'],
      expance: row['expance'],
      date: row['date'],
      source: row['source'],
      filter_date: row['filter_date'],
    );
  }
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'title': title,
      'expance_type': expance_type,
      'expance': expance,
      'date': date,
      'source': source,
      'filter_date': filter_date,
    };
  }
}
