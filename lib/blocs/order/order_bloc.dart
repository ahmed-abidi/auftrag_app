import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:auftrag_mobile/models/order.dart';
import 'package:auftrag_mobile/models/orderdetail.dart';
import 'package:auftrag_mobile/repositories/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({@required this.orderRepository})
      : assert(orderRepository != null),
        super(OrderEmpty());

  @override
  Stream<Transition<OrderEvent, OrderState>> transformEvents(
    Stream<OrderEvent> events,
    TransitionFunction<OrderEvent, OrderState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is FetchOrder) {
      yield* _mapFetchOrderToState(event);
    } else if (event is RefreshOrder) {
      yield* _mapRefreshOrderToState(event);
    } else if (event is Orderdetail) {
      //yield* _mapOrderdetailToState(event);
    } else if (event is Ordershow) {
      yield* _mapOrdershowToState(event);
    }
  }

  Stream<OrderState> _mapFetchOrderToState(FetchOrder event) async* {
    final currentState = state;

    if (!_hasReachedMax(currentState)) {
      try {
        if (currentState is OrderEmpty) {
          final orderPaginator = await orderRepository.getOrders(1);
          yield OrderLoaded(
              orders: orderPaginator.orders,
              hasReachedMax: orderPaginator.lastPage == 1 ? true : false);
          return;
        }

        if (currentState is OrderLoaded) {
          var pageNumber = currentState.pageNumber + 1;
          final orderPaginator = await orderRepository.getOrders(pageNumber);

          yield orderPaginator.orders.isEmpty
              ? OrderLoaded(
                  orders: currentState.orders,
                  hasReachedMax: true,
                  pageNumber: currentState.pageNumber,
                )
              : OrderLoaded(
                  orders: currentState.orders + orderPaginator.orders,
                  hasReachedMax: false,
                  pageNumber: pageNumber,
                );
        }
      } catch (_) {
        yield OrderError();
      }
    }
  }

  bool _hasReachedMax(OrderState state) =>
      state is OrderLoaded && state.hasReachedMax;

  Stream<OrderState> _mapRefreshOrderToState(RefreshOrder event) async* {
    try {
      final orderPaginator = await orderRepository.getOrders(1);
      yield OrderLoaded(
          orders: orderPaginator.orders,
          hasReachedMax: orderPaginator.lastPage == 1 ? true : false);
      return;
    } catch (_) {
      yield state;
    }
  }

  Stream<OrderState> _mapOrdershowToState(Ordershow event) async* {
    final currentState = state;
    if (currentState is OrderLoaded) {
      try {
        final order = await orderRepository.getOrderdetail(event.OrderID);

        // yield OrderLoading();
        yield Orderget(order: order);
      } catch (e) {
        yield OrderError();
        yield currentState;
      }
    }

    /* Stream<OrderState> _mapOrderdetailToState(Orderdetail event) async* {
    yield Orderdetailstate();
    final currentState = state;
    var id = currentState.id;
    try {
      final orderdetail = await orderRepository.getOrderdetail(id);
      yield Orderdetailstate(orderdetail: orderdetail);
    } catch (_) {
      yield OrderdetailError();
    }
  }*/

    /*Stream<OrderState> _mapUpdateReplyCountToState(
      UpdateReplyCount event) async* {
    final currentState = state;

    try {
      if (currentState is OrderLoaded) {
        final index = currentState.orders
            .indexWhere((element) => element.id == event.OrderID);

        final order = currentState.orders
            .firstWhere((element) => element.id == event.OrderID);

        final List<Order> updatedOrder = List.from(currentState.orders)
          ..replaceRange(index, index + 1, [
            order.copyWith(
              repliesCount: event.count,
            )
          ]);

        yield currentState.copyWith(orders: updatedOrder);
      }
    } catch (_) {
      yield state;
    }
  }*/

    /*Stream<OrderState> _mapDeleteOrderToState(DeleteOrder event) async* {
    final currentState = state;
    if (currentState is OrderLoaded) {
      try {
        await orderRepository.deleteOrder(event.OrderID);
        final List<Order> updatedOrders =
            _removeOrder(currentState.orders, event);

        // yield OrderLoading();
        yield OrderDeleted();
        yield currentState.copyWith(
          orders: updatedOrders,
        );
      } catch (e) {
        yield DeleteOrderError();
        yield currentState;
      }
    }
  }*/

    /*List<Order> _removeOrder(List<Order> orders, DeleteOrder event) {
    return orders.where((order) => order.id != event.OrderID).toList();
  }*/
  }
}
