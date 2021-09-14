// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pivot _$PivotFromJson(Map<String, dynamic> json) {
  return Pivot(
    order_id: json['order_id'] as int,
    invoice_id: json['invoice_id'] as int,
  );
}

Map<String, dynamic> _$PivotToJson(Pivot instance) => <String, dynamic>{
      'order_id': instance.order_id,
      'invoice_id': instance.invoice_id,
    };

Orders _$OrdersFromJson(Map<String, dynamic> json) {
  return Orders(
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
    callcustomer: json['callcustomer'] as int,
    recallcustomer: json['recallcustomer'] as int,
    customername: json['customername'] as String,
    customerlastname: json['customerlastname'] as String,
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
    totalprice: (json['totalprice'] as num)?.toDouble(),
    totalpricenet: (json['totalpricenet'] as num)?.toDouble(),
    totalincludprice: (json['totalincludprice'] as num)?.toDouble(),
    pivot: json['pivot'] == null
        ? null
        : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
    partner_fees: json['partner_fees'] as String,
    partners: (json['partners'] as List)
        ?.map((e) =>
            e == null ? null : Partners.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
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
      'callcustomer': instance.callcustomer,
      'recallcustomer': instance.recallcustomer,
      'customername': instance.customername,
      'customerlastname': instance.customerlastname,
      'user_id': instance.user_id,
      'customer_id': instance.customer_id,
      'partner_id': instance.partner_id,
      'service_id': instance.service_id,
      'service_name': instance.service_name,
      'created_at': instance.createdAt?.toIso8601String(),
      'update_at': instance.updateAt?.toIso8601String(),
      'totalprice': instance.totalprice,
      'totalpricenet': instance.totalpricenet,
      'totalincludprice': instance.totalincludprice,
      'partner_fees': instance.partner_fees,
      'partners': instance.partners,
      'pivot': instance.pivot,
    };

Invoicedetail _$InvoicedetailFromJson(Map<String, dynamic> json) {
  return Invoicedetail(
    id: json['id'] as int,
    type: json['type'] as String,
    composed: json['composed'] as int,
    price: json['price'] as String,
    material_price: json['material_price'] as String,
    brut_price: json['brut_price'] as String,
    brute_price: json['brute_price'] as String,
    tva: json['tva'] as String,
    description: json['description'] as String,
    status: json['status'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    method: json['method'] as String,
    included: json['included'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['update_at'] == null
        ? null
        : DateTime.parse(json['update_at'] as String),
    orders: (json['orders'] as List)
        ?.map((e) =>
            e == null ? null : Orders.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$InvoicedetailToJson(Invoicedetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'composed': instance.composed,
      'price': instance.price,
      'material_price': instance.material_price,
      'brut_price': instance.brut_price,
      'brute_price': instance.brute_price,
      'tva': instance.tva,
      'description': instance.description,
      'status': instance.status,
      'date': instance.date?.toIso8601String(),
      'method': instance.method,
      'included': instance.included,
      'created_at': instance.createdAt?.toIso8601String(),
      'update_at': instance.updatedAt?.toIso8601String(),
      'orders': instance.orders,
    };
