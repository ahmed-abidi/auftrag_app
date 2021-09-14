part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderEmpty extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  final bool hasReachedMax;
  final int pageNumber;

  const OrderLoaded(
      {@required this.orders, this.hasReachedMax, this.pageNumber = 1})
      : assert(orders != null);

  OrderLoaded copyWith({
    List<Order> orders,
    bool hasReachedMax,
    int pageNumber,
  }) {
    return OrderLoaded(
      orders: orders ?? this.orders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }

  @override
  List<Object> get props => [orders, hasReachedMax, pageNumber];

  @override
  String toString() =>
      'OrderLoaded { Order: ${orders.length}, hasReachedMax: $hasReachedMax }';
}

class OrderError extends OrderState {}

class Orderdetailstate {
  final Orderdetail orderdetail;

  const Orderdetailstate({@required this.orderdetail})
      : assert(orderdetail != null);

  @override
  Object get props => [orderdetail];
}

class OrderdetailError extends OrderState {}

class Orderget extends OrderState {
  final Order order;

  const Orderget({this.order}) : assert(order != null);

  @override
  List<Object> get props => [order];
}

/*class OrderDeleting extends OrderState {}

class OrderDeleted extends OrderState {}

class DeleteOrderError extends OrderState {}*/
