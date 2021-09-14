import 'package:json_annotation/json_annotation.dart';
import 'package:auftrag_mobile/models/invoice.dart';

part 'invoice_paginator.g.dart';

@JsonSerializable()
class InvoicePaginator {
  @JsonKey(name: 'current_page')
  int currentPage;

  @JsonKey(name: 'last_page')
  int lastPage;

  @JsonKey(name: 'data')
  List<Invoice> invoices;

  InvoicePaginator({
    this.currentPage,
    this.lastPage,
    this.invoices,
  });

  factory InvoicePaginator.fromJson(Map<String, dynamic> json) =>
      _$InvoicePaginatorFromJson(json);

  Map<String, dynamic> toJson() => _$InvoicePaginatorToJson(this);
}
