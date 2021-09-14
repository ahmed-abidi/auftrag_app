import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:auftrag_mobile/models/invoice.dart';
import 'package:auftrag_mobile/repositories/invoice_repository.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final InvoiceRepository invoiceRepository;

  InvoiceBloc({@required this.invoiceRepository})
      : assert(invoiceRepository != null),
        super(InvoiceEmpty());

  @override
  Stream<Transition<InvoiceEvent, InvoiceState>> transformEvents(
    Stream<InvoiceEvent> events,
    TransitionFunction<InvoiceEvent, InvoiceState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<InvoiceState> mapEventToState(InvoiceEvent event) async* {
    if (event is FetchInvoice) {
      yield* _mapFetchInvoiceToState(event);
    }
    /*else if (event is RefreshInvoice) {
      yield* _mapRefreshInvoiceToState(event);
    }*/
    /*else if (event is PublishOrder) {
      yield* _mapPublishOrderToState(event);
    }*/
  }

  Stream<InvoiceState> _mapFetchInvoiceToState(event) async* {
    try {
      final invoices = await invoiceRepository.getInvoices();
      yield InvoiceLoaded(invoices: invoices);
    } catch (_) {
      yield InvoiceError();
    }
  }
}
