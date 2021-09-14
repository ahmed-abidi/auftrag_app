part of 'invoice_bloc.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

class InvoiceEmpty extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceLoaded extends InvoiceState {
  final List<Invoice> invoices;

  const InvoiceLoaded({@required this.invoices}) : assert(invoices != null);

  @override
  List<Object> get props => [invoices];
}

class InvoiceError extends InvoiceState {}
