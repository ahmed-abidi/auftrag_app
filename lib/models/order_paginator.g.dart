// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_paginator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPaginator _$OrderPaginatorFromJson(Map<String, dynamic> json) {
  return OrderPaginator(
    currentPage: json['current_page'] as int,
    lastPage: json['last_page'] as int,
    orders: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderPaginatorToJson(OrderPaginator instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.orders,
    };
