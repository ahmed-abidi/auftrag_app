import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Pivot {
  // ignore: non_constant_identifier_names
  int partner_id;
  // ignore: non_constant_identifier_names
  int order_id;

  Pivot(
      {
      // ignore: non_constant_identifier_names
      this.partner_id,
      // ignore: non_constant_identifier_names
      this.order_id});

  factory Pivot.fromJson(Map<String, dynamic> json) => _$PivotFromJson(json);

  Map<String, dynamic> toJson() => _$PivotToJson(this);
}

@JsonSerializable()
class Customer {
  int id;
  @JsonKey(name: 'first_name')
  String firstname;
  @JsonKey(name: 'last_name')
  String lastname;
  String phone;
  String phone1;
  String fax;
  String company;
  String type;
  String sex;
  String email;
  @JsonKey(name: 'created_at')
  DateTime createdct;
  @JsonKey(name: 'update_at')
  DateTime updatect;

  Customer({
    this.id,
    this.firstname,
    this.lastname,
    this.phone,
    this.phone1,
    this.fax,
    this.type,
    this.sex,
    this.email,
    this.createdct,
    this.updatect,
  });
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

@JsonSerializable()
class Order {
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
  // ignore: non_constant_identifier_names
  String city;
  String street;
  int callcustomer;
  int recallcustomer;
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

  Pivot pivot;
  Customer customer;

  Order(
      {this.id,
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
      // ignore: non_constant_identifier_names
      this.city,
      this.street,
      this.callcustomer,
      this.recallcustomer,
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
      this.pivot,
      this.customer});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order copyWith(
      {int id,
      String status,
      String reason,
      String percent,
      String description,
      String description1,
      String startdate,
      String starttime,
      String enddate,
      String endtime,
      int emergency,
      int makeappointment,
      int beponctual,
      int noprice,
      String address,
      int callcustomer,
      int recallcustomer,
      int userid,
      int customerid,
      // ignore: non_constant_identifier_names
      int service_id,
      // ignore: non_constant_identifier_names
      String service_name,
      DateTime createdAt,
      DateTime upateAt,
      Pivot pivot,
      Customer customer}) {
    return Order(
        id: id ?? this.id,
        status: status ?? this.status,
        reason: reason ?? this.reason,
        percent: percent ?? this.percent,
        description: description ?? this.description,
        description1: description1 ?? this.description1,
        start_date: start_date ?? this.start_date,
        start_time: start_time ?? this.start_time,
        end_date: end_date ?? this.end_date,
        end_time: end_time ?? this.end_time,
        emergency: emergency ?? this.emergency,
        make_appointment: make_appointment ?? this.make_appointment,
        be_ponctual: be_ponctual ?? this.be_ponctual,
        no_price: no_price ?? this.no_price,
        address: address ?? this.address,
        city: city ?? this.city,
        callcustomer: callcustomer ?? this.callcustomer,
        recallcustomer: recallcustomer ?? this.recallcustomer,
        user_id: user_id ?? this.user_id,
        partner_id: partner_id ?? this.partner_id,
        customer_id: customer_id ?? this.customer_id,
        service_id: service_id ?? this.service_id,
        service_name: service_name ?? this.service_name,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        pivot: pivot ?? this.pivot,
        customer: customer ?? this.customer);
  }
}
