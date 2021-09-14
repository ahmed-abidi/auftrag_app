import 'package:json_annotation/json_annotation.dart';
import 'package:auftrag_mobile/models/partners.dart';

part 'invoice_detail.g.dart';

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
class Orders {
  int id;

  @JsonKey(nullable: true)
  String status;
  String reason;
  String percent;
  String description;
  String description1;
  // ignore: non_constant_identifier_names
  String start_date;
  // ignore: non_constant_identifier_names
  String start_time;
  // ignore: non_constant_identifier_names
  String end_date;
  // ignore: non_constant_identifier_names
  String end_time;
  int emergency;
  // ignore: non_constant_identifier_names
  int make_appointment;
  // ignore: non_constant_identifier_names
  int be_ponctual;
  // ignore: non_constant_identifier_names
  int no_price;
  String address;
  int callcustomer;
  int recallcustomer;
  String customername;
  String customerlastname;
  // ignore: non_constant_identifier_names
  int user_id;
  // ignore: non_constant_identifier_names
  int customer_id;
  // ignore: non_constant_identifier_names
  int partner_id;
  // ignore: non_constant_identifier_names
  int service_id;
  // ignore: non_constant_identifier_names
  String service_name;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'update_at')
  DateTime updateAt;
  double totalprice;
  double totalpricenet;
  double totalincludprice;
  // ignore: non_constant_identifier_names
  String partner_fees;
  List<Partners> partners;

  Pivot pivot;
  Orders({
    this.id,
    this.status,
    this.reason,
    this.percent,
    this.description,
    this.description1,
    // ignore: non_constant_identifier_names
    this.start_date,
    // ignore: non_constant_identifier_names
    this.start_time,
    // ignore: non_constant_identifier_names
    this.end_date,
    // ignore: non_constant_identifier_names
    this.end_time,
    this.emergency,
    // ignore: non_constant_identifier_names
    this.make_appointment,
    // ignore: non_constant_identifier_names
    this.be_ponctual,
    // ignore: non_constant_identifier_names
    this.no_price,
    this.address,
    this.callcustomer,
    this.recallcustomer,
    this.customername,
    this.customerlastname,
    // ignore: non_constant_identifier_names
    this.user_id,
    // ignore: non_constant_identifier_names
    this.partner_id,
    // ignore: non_constant_identifier_names
    this.customer_id,
    // ignore: non_constant_identifier_names
    this.service_id,
    // ignore: non_constant_identifier_names
    this.service_name,
    this.createdAt,
    this.updateAt,
    this.totalprice,
    this.totalpricenet,
    this.totalincludprice,
    this.pivot,
    // ignore: non_constant_identifier_names
    this.partner_fees,
    this.partners,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}

@JsonSerializable()
class Invoicedetail {
  int id;

  @JsonKey(nullable: true)
  String type;
  int composed;
  String price;
  // ignore: non_constant_identifier_names
  String material_price;
  // ignore: non_constant_identifier_names
  String brut_price;
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
  List<Orders> orders;

  Invoicedetail(
      {this.id,
      this.type,
      this.composed,
      this.price,
      // ignore: non_constant_identifier_names
      this.material_price,
      // ignore: non_constant_identifier_names
      this.brut_price,
      this.brute_price,
      this.tva,
      this.description,
      this.status,
      this.date,
      this.method,
      this.included,
      this.createdAt,
      this.updatedAt,
      this.orders});

  factory Invoicedetail.fromJson(Map<String, dynamic> json) =>
      _$InvoicedetailFromJson(json);
  Map<String, dynamic> toJson() => _$InvoicedetailToJson(this);

  Invoicedetail copyWith(
      {int id,
      String type,
      int composed,
      String price,
      // ignore: non_constant_identifier_names
      String material_price,
      // ignore: non_constant_identifier_names
      String brut_price,
      String tva,
      String description,
      String status,
      DateTime date,
      String method,
      int included,
      DateTime createdAt,
      DateTime updatedAt,
      Pivot pivot,
      Orders orders}) {
    return Invoicedetail(
      id: id ?? this.id,
      type: type ?? this.type,
      composed: composed ?? this.composed,
      price: price ?? this.price,
      material_price: material_price ?? this.material_price,
      brut_price: brut_price ?? this.brut_price,
      brute_price: brute_price ?? this.brute_price,
      tva: tva ?? this.tva,
      description: description ?? this.description,
      status: status ?? this.status,
      date: date ?? this.date,
      method: method ?? this.method,
      included: included ?? this.included,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      orders: orders ?? this.orders,
    );
  }
}
