// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderdetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    id: json['id'] as int,
    firstname: json['first_name'] as String,
    lastname: json['last_name'] as String,
    phone: json['phone'] as String,
    phone1: json['phone1'] as String,
    fax: json['fax'] as String,
    type: json['type'] as String,
    sex: json['sex'] as String,
    email: json['email'] as String,
    createdct: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatect: json['update_at'] == null
        ? null
        : DateTime.parse(json['update_at'] as String),
  )..company = json['company'] as String;
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstname,
      'last_name': instance.lastname,
      'phone': instance.phone,
      'phone1': instance.phone1,
      'fax': instance.fax,
      'company': instance.company,
      'type': instance.type,
      'sex': instance.sex,
      'email': instance.email,
      'created_at': instance.createdct?.toIso8601String(),
      'update_at': instance.updatect?.toIso8601String(),
    };

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service(
    id: json['id'] as int,
    name: json['name'] as String,
    createdst: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatest: json['update_at'] == null
        ? null
        : DateTime.parse(json['update_at'] as String),
  );
}

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdst?.toIso8601String(),
      'update_at': instance.updatest?.toIso8601String(),
    };

Orderdetail _$OrderdetailFromJson(Map<String, dynamic> json) {
  return Orderdetail(
    id: json['id'] as int,
    status: json['status'] as String,
    reason: json['reason'] as String,
    price: json['price'] as String,
    description: json['description'] as String,
    description1: json['description1'] as String,
    startdate: json['startdate'] as String,
    starttime: json['starttime'] as String,
    enddate: json['enddate'] as String,
    endtime: json['endtime'] as String,
    emergency: json['emergency'] as int,
    makeappointment: json['makeappointment'] as int,
    beponctual: json['beponctual'] as int,
    noprice: json['noprice'] as int,
    callcustomer: json['callcustomer'] as int,
    recallcustomer: json['recallcustomer'] as int,
    userid: json['userid'] as int,
    customerid: json['customerid'] as int,
    serviceid: json['serviceid'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['update_at'] == null
        ? null
        : DateTime.parse(json['update_at'] as String),
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    customer: json['customer'] == null
        ? null
        : Customer.fromJson(json['customer'] as Map<String, dynamic>),
    service: json['service'] == null
        ? null
        : Service.fromJson(json['service'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderdetailToJson(Orderdetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'reason': instance.reason,
      'price': instance.price,
      'description': instance.description,
      'description1': instance.description1,
      'startdate': instance.startdate,
      'starttime': instance.starttime,
      'enddate': instance.enddate,
      'endtime': instance.endtime,
      'emergency': instance.emergency,
      'makeappointment': instance.makeappointment,
      'beponctual': instance.beponctual,
      'noprice': instance.noprice,
      'callcustomer': instance.callcustomer,
      'recallcustomer': instance.recallcustomer,
      'userid': instance.userid,
      'customerid': instance.customerid,
      'serviceid': instance.serviceid,
      'customer': instance.customer,
      'service': instance.service,
      'user': instance.user,
      'created_at': instance.createdAt?.toIso8601String(),
      'update_at': instance.updateAt?.toIso8601String(),
    };
