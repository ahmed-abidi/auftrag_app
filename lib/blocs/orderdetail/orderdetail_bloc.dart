/*import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:auftrag_mobile/models/orderdetail.dart';
import 'package:auftrag_mobile/repositories/order_repository.dart';

part 'orderdetail_event.dart';
part 'orderdetail_state.dart';

class OrderdetailBloc extends Bloc<OrderdetailEvent, OrderdetailState> {
  final OrderRepository orderRepository;
  final Orderdetail orderdetaill;

  OrderdetailBloc({@required this.orderRepository})
      : assert(orderRepository != null),
        super(OrderdetailInitial());

  @override
  Stream<OrderdetailState> mapEventToState(
    OrderdetailEvent event,
  ) async* {
    if (event is OrderdetailEvent) {
      yield* _mapFetchOrderdetailToState();
    }
  }

  Stream<OrderdetailState> _mapFetchOrderdetailToState() async* {
    final currentState = state;
    final int id = orderdetaill.id;
    yield Orderdetaile();
    if (currentState is Orderdetaile) {
      yield Orderdetaile(orderdetail: currentState.orderdetail);
    }
    try {
      final orderdetail = await OrderRepository.getOrderdetail();
      yield orderdetail(orderdetail: orderdetail);
    } catch (e) {
      yield OrderdetailError();
    }
  }

  Stream<OrderdetailState> _mapUnfollowUserToState(UnfollowUser event) async* {
    try {
      final user = await followRepository.toggleFollow(event.user.username);
      yield Unfollowed(user: user);
    } catch (e) {
      yield FollowError();
    }
  }
}*/
