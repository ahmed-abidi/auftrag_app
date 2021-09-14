import 'package:json_annotation/json_annotation.dart';
import 'package:auftrag_mobile/models/user.dart';

part 'orderdetail.g.dart';

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
class Service {
  int id;
  String name;
  @JsonKey(name: 'created_at')
  DateTime createdst;
  @JsonKey(name: 'update_at')
  DateTime updatest;

  Service({
    this.id,
    this.name,
    this.createdst,
    this.updatest,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}

@JsonSerializable()
class Orderdetail {
  int id;

  @JsonKey(nullable: true)
  String status;
  String reason;
  String price;
  String description;
  String description1;
  String startdate;
  String starttime;
  String enddate;
  String endtime;
  int emergency;
  int makeappointment;
  int beponctual;
  int noprice;
  int callcustomer;
  int recallcustomer;
  int userid;
  int customerid;
  int serviceid;
  Customer customer;
  Service service;

  User user;

  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'update_at')
  DateTime updateAt;

  Orderdetail(
      {this.id,
      this.status,
      this.reason,
      this.price,
      this.description,
      this.description1,
      this.startdate,
      this.starttime,
      this.enddate,
      this.endtime,
      this.emergency,
      this.makeappointment,
      this.beponctual,
      this.noprice,
      this.callcustomer,
      this.recallcustomer,
      this.userid,
      this.customerid,
      this.serviceid,
      this.createdAt,
      this.updateAt,
      this.user,
      this.customer,
      this.service});

  factory Orderdetail.fromJson(Map<String, dynamic> json) =>
      _$OrderdetailFromJson(json);

  Map<String, dynamic> toJson() => _$OrderdetailToJson(this);

  Orderdetail copyWith({
    int id,
    String status,
    String reason,
    String price,
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
    int callcustomer,
    int recallcustomer,
    int userid,
    int customerid,
    int serviceid,
    DateTime createdAt,
    DateTime updateAt,
    User user,
    Customer customer,
    Service service,
  }) {
    return Orderdetail(
        id: id ?? this.id,
        status: status ?? this.status,
        reason: reason ?? this.reason,
        price: price ?? this.price,
        description: description ?? this.description,
        description1: description1 ?? this.description1,
        startdate: startdate ?? this.startdate,
        starttime: starttime ?? this.starttime,
        enddate: enddate ?? this.enddate,
        endtime: endtime ?? this.endtime,
        emergency: emergency ?? this.emergency,
        makeappointment: makeappointment ?? this.makeappointment,
        beponctual: beponctual ?? this.beponctual,
        noprice: noprice ?? this.noprice,
        callcustomer: callcustomer ?? this.callcustomer,
        recallcustomer: recallcustomer ?? this.recallcustomer,
        userid: userid ?? this.userid,
        customerid: customerid ?? this.customerid,
        serviceid: serviceid ?? this.serviceid,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        user: user ?? this.user,
        customer: customer ?? this.customer,
        service: service ?? this.service);
  }
}
