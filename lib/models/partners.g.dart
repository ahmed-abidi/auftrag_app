// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partners.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pivot _$PivotFromJson(Map<String, dynamic> json) {
  return Pivot(
    order_id: json['order_id'] as int,
    partner_id: json['partner_id'] as int,
    status: json['status'] as String,
    reason: json['reason'] as String,
    created_at: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updated_at: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$PivotToJson(Pivot instance) => <String, dynamic>{
      'order_id': instance.order_id,
      'partner_id': instance.partner_id,
      'status': instance.status,
      'reason': instance.reason,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };

Partners _$PartnersFromJson(Map<String, dynamic> json) {
  return Partners(
    id: json['id'] as int,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    birthday: json['birthday'] == null
        ? null
        : DateTime.parse(json['birthday'] as String),
    document: json['document'] as String,
    cv: json['cv'] as String,
    phone: json['phone'] as String,
    phone1: json['phone1'] as String,
    image: json['image'] as String,
    company: json['company'] as String,
    fax: json['fax'] as String,
    website: json['website'] as String,
    has_fees: json['has_fees'] as int,
    block_accept: json['block_accept'] as int,
    fees: json['fees'] as String,
    percentage: json['percentage'] as String,
    user_id: json['user_id'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['update_at'] == null
        ? null
        : DateTime.parse(json['update_at'] as String),
    pivot: json['pivot'] == null
        ? null
        : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PartnersToJson(Partners instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'birthday': instance.birthday?.toIso8601String(),
      'document': instance.document,
      'cv': instance.cv,
      'phone': instance.phone,
      'phone1': instance.phone1,
      'image': instance.image,
      'company': instance.company,
      'fax': instance.fax,
      'website': instance.website,
      'has_fees': instance.has_fees,
      'block_accept': instance.block_accept,
      'fees': instance.fees,
      'percentage': instance.percentage,
      'user_id': instance.user_id,
      'created_at': instance.createdAt?.toIso8601String(),
      'update_at': instance.updateAt?.toIso8601String(),
      'pivot': instance.pivot,
    };
