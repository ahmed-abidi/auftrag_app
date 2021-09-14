import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:auftrag_mobile/models/order.dart';
import 'package:auftrag_mobile/preferences/preferences.dart';
import 'package:auftrag_mobile/repositories/search_repository.dart';

part 'order_search_event.dart';
part 'order_search_state.dart';

class OrderSearchBloc extends Bloc<OrderSearchEvent, OrderSearchState> {
  final SearchRepository searchRepository;

  OrderSearchBloc({@required this.searchRepository})
      : assert(searchRepository != null),
        super(OrderSearchState.initial());

  @override
  void onTransition(Transition<OrderSearchEvent, OrderSearchState> transition) {
    print(transition.toString());
    super.onTransition(transition);
  }

  @override
  Stream<Transition<OrderSearchEvent, OrderSearchState>> transformEvents(
    Stream<OrderSearchEvent> events,
    TransitionFunction<OrderSearchEvent, OrderSearchState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 300)),
      transitionFn,
    );
  }

  @override
  Stream<OrderSearchState> mapEventToState(
    OrderSearchEvent event,
  ) async* {
    yield OrderSearchState.loading();
    try {
      List<Order> orders = await searchRepository.searchOrders(event.query);
      _saveToRecentSearch(event.query);
      yield OrderSearchState.success(orders);
    } catch (_) {
      yield OrderSearchState.error();
    }
  }

  void _saveToRecentSearch(String query) async {
    Set<String> allSearches =
        Prefer.prefs.getStringList("recent_searches")?.toSet() ?? {};

    allSearches = {query, ...allSearches};
    Prefer.prefs.setStringList("recent_searches", allSearches.toList());
  }
}
