part of 'order_search_bloc.dart';

class OrderSearchState {
  final bool isLoading;
  final List<Order> orders;
  final bool hasError;

  const OrderSearchState({
    this.isLoading,
    this.orders,
    this.hasError,
  });

  factory OrderSearchState.initial() {
    return OrderSearchState(
      orders: [],
      isLoading: false,
      hasError: false,
    );
  }

  factory OrderSearchState.loading() {
    return OrderSearchState(
      orders: [],
      isLoading: true,
      hasError: false,
    );
  }

  factory OrderSearchState.success(List<Order> orders) {
    return OrderSearchState(
      orders: orders,
      isLoading: false,
      hasError: false,
    );
  }

  factory OrderSearchState.error() {
    return OrderSearchState(
      orders: [],
      isLoading: false,
      hasError: true,
    );
  }

  @override
  String toString() =>
      'OrderSearchState {tweets: ${orders.toString()}, isLoading: $isLoading, hasError: $hasError }';
}
