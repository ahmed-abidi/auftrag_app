part of 'order_search_bloc.dart';

class OrderSearchEvent {
  final String query;

  const OrderSearchEvent(this.query);

  @override
  String toString() => 'OrderSearchEvent { query: $query }';
}
