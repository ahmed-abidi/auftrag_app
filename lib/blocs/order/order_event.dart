part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class FetchOrder extends OrderEvent {
  @override
  List<Object> get props => [];
}

class RefreshOrder extends OrderEvent {
  @override
  List<Object> get props => [];
}

class Orderdetail {
  final Orderdetail orderdetail;
  final int id;

  const Orderdetail({@required this.orderdetail, @required this.id})
      : assert(orderdetail != null);

  @override
  List<Object> get props => [];
}

class Ordershow extends OrderEvent {
  final int OrderID;

  Ordershow({this.OrderID});

  @override
  List<Object> get props => [];
}

/*class UpdateReplyCount extends OrderEvent {
  final int OrderID;
  final int count;

  UpdateReplyCount({this.OrderID, this.count});

  @override
  List<Object> get props => [];
}

class DeleteOrder extends OrderEvent {
  final int OrderID;

  DeleteOrder({this.OrderID});

  @override
  List<Object> get props => [];
}*/
