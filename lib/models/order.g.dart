// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pivot _$PivotFromJson(Map<String, dynamic> json) {
  return Pivot(
    partner_id: json['partner_id'] as int,
    order_id: json['order_id'] as int,
  );
}

Map<String, dynamic> _$PivotToJson(Pivot instance) => <String, dynamic>{
      'partner_id': instance.partner_id,
      'order_id': instance.order_id,
    };

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

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['id'] as int,
    status: json['status'] as String,
    reason: json['reason'] as String,
    percent: json['percent'] as String,
    description: json['description'] as String,
    description1: json['description1'] as String,
    start_date: json['start_date'] as String,
    start_time: json['start_time'] as String,
    end_date: json['end_date'] as String,
    end_time: json['end_time'] as String,
    emergency: json['emergency'] as int,
    make_appointment: json['make_appointment'] as int,
    be_ponctual: json['be_ponctual'] as int,
    no_price: json['no_price'] as int,
    address: json['address'] as String,
    city: json['city'] as String,
    street: json['street'] as String,
    callcustomer: json['callcustomer'] as int,
    recallcustomer: json['recallcustomer'] as int,
    user_id: json['user_id'] as int,
    partner_id: json['partner_id'] as int,
    customer_id: json['customer_id'] as int,
    service_id: json['service_id'] as int,
    service_name: json['service_name'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['update_at'] == null
        ? null
        : DateTime.parse(json['update_at'] as String),
    pivot: json['pivot'] == null
        ? null
        : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
    customer: json['customer'] == null
        ? null
        : Customer.fromJson(json['customer'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'reason': instance.reason,
      'percent': instance.percent,
      'description': instance.description,
      'description1': instance.description1,
      'start_date': instance.start_date,
      'start_time': instance.start_time,
      'end_date': instance.end_date,
      'end_time': instance.end_time,
      'emergency': instance.emergency,
      'make_appointment': instance.make_appointment,
      'be_ponctual': instance.be_ponctual,
      'no_price': instance.no_price,
      'address': instance.address,
      'city': instance.city,
      'street': instance.street,
      'callcustomer': instance.callcustomer,
      'recallcustomer': instance.recallcustomer,
      'user_id': instance.user_id,
      'customer_id': instance.customer_id,
      'partner_id': instance.partner_id,
      'service_id': instance.service_id,
      'service_name': instance.service_name,
      'created_at': instance.createdAt?.toIso8601String(),
      'update_at': instance.updateAt?.toIso8601String(),
      'pivot': instance.pivot,
      'customer': instance.customer,
    };
