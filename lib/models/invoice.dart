import 'package:json_annotation/json_annotation.dart';

part 'invoice.g.dart';

@JsonSerializable()
class Pivot {
  // ignore: non_constant_identifier_names
  int order_id;
  // ignore: non_constant_identifier_names
  int invoice_id;

  Pivot(
      {
      // ignore: non_constant_identifier_names
      this.order_id,
      // ignore: non_constant_identifier_names
      this.invoice_id});

  factory Pivot.fromJson(Map<String, dynamic> json) => _$PivotFromJson(json);

  Map<String, dynamic> toJson() => _$PivotToJson(this);
}

@JsonSerializable()
class Invoice {
  int id;

  @JsonKey(nullable: true)
  String type;
  int composed;
  String price;
  // ignore: non_constant_identifier_names
  String material_price;
  // ignore: non_constant_identifier_names
  String brute_price;
  String tva;
  String description;
  String status;
  DateTime date;
  String method;
  int included;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'update_at')
  DateTime updatedAt;
  Pivot pivot;

  Invoice({
    this.id,
    this.type,
    this.composed,
    this.price,
    // ignore: non_constant_identifier_names
    this.material_price,
    // ignore: non_constant_identifier_names
    this.brute_price,
    this.tva,
    this.description,
    this.status,
    this.date,
    this.method,
    this.included,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  Invoice copyWith(
      {int id,
      String type,
      int composed,
      String price,
      // ignore: non_constant_identifier_names
      String material_price,
      // ignore: non_constant_identifier_names
      String brute_price,
      String tva,
      String description,
      String status,
      DateTime date,
      String method,
      int included,
      DateTime createdAt,
      DateTime updatedAt,
      Pivot pivot}) {
    return Invoice(
        id: id ?? this.id,
        type: type ?? this.type,
        composed: composed ?? this.composed,
        price: price ?? this.price,
        material_price: material_price ?? this.material_price,
        brute_price: brute_price ?? this.brute_price,
        tva: tva ?? this.tva,
        description: description ?? this.description,
        status: status ?? this.status,
        date: date ?? this.date,
        method: method ?? this.method,
        included: included ?? this.included,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pivot: pivot ?? this.pivot);
  }
}
