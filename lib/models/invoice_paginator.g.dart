// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_paginator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoicePaginator _$InvoicePaginatorFromJson(Map<String, dynamic> json) {
  return InvoicePaginator(
    currentPage: json['current_page'] as int,
    lastPage: json['last_page'] as int,
    invoices: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Invoice.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$InvoicePaginatorToJson(InvoicePaginator instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.invoices,
    };
