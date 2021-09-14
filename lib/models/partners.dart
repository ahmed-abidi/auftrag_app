import 'package:json_annotation/json_annotation.dart';

part 'partners.g.dart';

@JsonSerializable()
class Pivot {
  // ignore: non_constant_identifier_names
  int order_id;
  // ignore: non_constant_identifier_names
  int partner_id;
  String status;
  String reason;
  // ignore: non_constant_identifier_names
  DateTime created_at;
  // ignore: non_constant_identifier_names
  DateTime updated_at;

  Pivot(
      {
      // ignore: non_constant_identifier_names
      this.order_id,
      // ignore: non_constant_identifier_names
      this.partner_id,
      this.status,
      this.reason,
      // ignore: non_constant_identifier_names
      this.created_at,
      // ignore: non_constant_identifier_names
      this.updated_at});

  factory Pivot.fromJson(Map<String, dynamic> json) => _$PivotFromJson(json);

  Map<String, dynamic> toJson() => _$PivotToJson(this);
}

@JsonSerializable()
class Partners {
  int id;

  @JsonKey(nullable: true)
  // ignore: non_constant_identifier_names
  String first_name;
  // ignore: non_constant_identifier_names
  String last_name;
  DateTime birthday;
  String document;
  String cv;
  // ignore: non_constant_identifier_names
  String phone;
  // ignore: non_constant_identifier_names
  String phone1;
  // ignore: non_constant_identifier_names
  String image;
  // ignore: non_constant_identifier_names
  String company;
  String fax;
  // ignore: non_constant_identifier_names
  String website;
  // ignore: non_constant_identifier_names
  int has_fees;
  // ignore: non_constant_identifier_names
  int block_accept;
  String fees;
  String percentage;

  // ignore: non_constant_identifier_names
  int user_id;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'update_at')
  DateTime updateAt;

  Pivot pivot;

  Partners({
    this.id,
    // ignore: non_constant_identifier_names
    this.first_name,
    // ignore: non_constant_identifier_names
    this.last_name,
    this.birthday,
    this.document,
    this.cv,
    // ignore: non_constant_identifier_names
    this.phone,
    // ignore: non_constant_identifier_names
    this.phone1,
    // ignore: non_constant_identifier_names
    this.image,
    // ignore: non_constant_identifier_names
    this.company,
    this.fax,
    // ignore: non_constant_identifier_names
    this.website,
    // ignore: non_constant_identifier_names
    this.has_fees,
    // ignore: non_constant_identifier_names
    this.block_accept,
    this.fees,
    this.percentage,
    // ignore: non_constant_identifier_names
    this.user_id,
    this.createdAt,
    this.updateAt,
    this.pivot,
  });

  factory Partners.fromJson(Map<String, dynamic> json) =>
      _$PartnersFromJson(json);

  Map<String, dynamic> toJson() => _$PartnersToJson(this);

  Partners copyWith({
    int id,
    // ignore: non_constant_identifier_names
    String first_name,
    // ignore: non_constant_identifier_names
    String last_name,
    DateTime birthday,
    String document,
    String cv,
    String phone,
    String phone1,
    String image,
    String company,
    int fax,
    int website,
    // ignore: non_constant_identifier_names
    int has_fees,
    // ignore: non_constant_identifier_names
    int block_accept,
    String fees,
    String percentage,
    // ignore: non_constant_identifier_names
    int user_id,
    DateTime createdAt,
    DateTime upateAt,
    Pivot pivot,
  }) {
    return Partners(
      id: id ?? this.id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      birthday: birthday ?? this.birthday,
      document: document ?? this.document,
      cv: cv ?? this.cv,
      phone: phone ?? this.phone,
      phone1: phone1 ?? this.phone1,
      image: image ?? this.image,
      company: company ?? this.company,
      fax: fax ?? this.fax,
      website: website ?? this.website,
      block_accept: block_accept ?? this.block_accept,
      fees: fees ?? this.fees,
      percentage: percentage ?? this.percentage,
      user_id: user_id ?? this.user_id,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      pivot: pivot ?? this.pivot,
    );
  }
}
