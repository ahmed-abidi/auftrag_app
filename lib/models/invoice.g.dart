// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

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

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return Invoice(
    id: json['id'] as int,
    type: json['type'] as String,
    composed: json['composed'] as int,
    price: json['price'] as String,
    material_price: json['material_price'] as String,
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
    pivot: json['pivot'] == null
        ? null
        : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'composed': instance.composed,
      'price': instance.price,
      'material_price': instance.material_price,
      'brute_price': instance.brute_price,
      'tva': instance.tva,
      'description': instance.description,
      'status': instance.status,
      'date': instance.date?.toIso8601String(),
      'method': instance.method,
      'included': instance.included,
      'created_at': instance.createdAt?.toIso8601String(),
      'update_at': instance.updatedAt?.toIso8601String(),
      'pivot': instance.pivot,
    };
