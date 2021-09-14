import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:auftrag_mobile/models/invoice.dart';
import 'package:auftrag_mobile/preferences/preferences.dart';
import 'package:auftrag_mobile/repositories/search_repository.dart';

class InvoiceSearchBloc extends Bloc<InvoiceSearchEvent, InvoiceSearchState> {
  final SearchRepository searchRepository;

  InvoiceSearchBloc({@required this.searchRepository})
      : assert(searchRepository != null),
        super(InvoiceSearchState.initial());

  @override
  void onTransition(
      Transition<InvoiceSearchEvent, InvoiceSearchState> transition) {
    print(transition.toString());
    super.onTransition(transition);
  }

  @override
  Stream<Transition<InvoiceSearchEvent, InvoiceSearchState>> transformEvents(
    Stream<InvoiceSearchEvent> events,
    TransitionFunction<InvoiceSearchEvent, InvoiceSearchState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 300)),
      transitionFn,
    );
  }

  @override
  Stream<InvoiceSearchState> mapEventToState(
    InvoiceSearchEvent event,
  ) async* {
    yield InvoiceSearchState.loading();
    try {
      List<Invoice> invoices =
          await searchRepository.searchInvoice(event.query);
      _saveToRecentSearch(event.query);
      yield InvoiceSearchState.success(invoices);
    } catch (_) {
      yield InvoiceSearchState.error();
    }
  }

  void _saveToRecentSearch(String query) async {
    Set<String> allSearches =
        Prefer.prefs.getStringList("recent_searches")?.toSet() ?? {};

    allSearches = {query, ...allSearches};
    Prefer.prefs.setStringList("recent_searches", allSearches.toList());
  }
}

class InvoiceSearchEvent {
  final String query;

  const InvoiceSearchEvent(this.query);

  @override
  String toString() => 'InvoiceSearchEvent { query: $query }';
}

class InvoiceSearchState {
  final bool isLoading;
  final List<Invoice> invoices;
  final bool hasError;

  const InvoiceSearchState({
    this.isLoading,
    this.invoices,
    this.hasError,
  });

  factory InvoiceSearchState.initial() {
    return InvoiceSearchState(
      invoices: [],
      isLoading: false,
      hasError: false,
    );
  }

  factory InvoiceSearchState.loading() {
    return InvoiceSearchState(
      invoices: [],
      isLoading: true,
      hasError: false,
    );
  }

  factory InvoiceSearchState.success(List<Invoice> invoices) {
    return InvoiceSearchState(
      invoices: invoices,
      isLoading: false,
      hasError: false,
    );
  }

  factory InvoiceSearchState.error() {
    return InvoiceSearchState(
      invoices: [],
      isLoading: false,
      hasError: true,
    );
  }

  @override
  String toString() =>
      'UserSearchState {users: ${invoices.toString()}, isLoading: $isLoading, hasError: $hasError }';
}
