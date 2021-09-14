import 'package:json_annotation/json_annotation.dart';
import 'package:auftrag_mobile/models/order.dart';

part 'order_paginator.g.dart';

@JsonSerializable()
class OrderPaginator {
  @JsonKey(name: 'current_page')
  int currentPage;

  @JsonKey(name: 'last_page')
  int lastPage;

  @JsonKey(name: 'data')
  List<Order> orders;

  OrderPaginator({
    this.currentPage,
    this.lastPage,
    this.orders,
  });

  factory OrderPaginator.fromJson(Map<String, dynamic> json) =>
      _$OrderPaginatorFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPaginatorToJson(this);
}
