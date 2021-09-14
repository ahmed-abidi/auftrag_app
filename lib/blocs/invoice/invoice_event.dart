part of 'invoice_bloc.dart';

abstract class InvoiceEvent extends Equatable {
  const InvoiceEvent();
}

class FetchInvoice extends InvoiceEvent {
  @override
  List<Object> get props => [];
}

class RefreshInvoice extends InvoiceEvent {
  @override
  List<Object> get props => [];
}

/*class PublishInvoice extends InvoiceEvent {
  final String body;
  final File image;

  const PublishInvoice({@required this.body, this.image})
      : assert(body != null);

  @override
  List<Object> get props => [];
}

class UpdateReplyCount extends InvoiceEvent {
  final int InvoiceID;
  final int count;

  UpdateReplyCount({this.InvoiceID, this.count});

  @override
  List<Object> get props => [];
}

class DeleteInvoice extends InvoiceEvent {
  final int InvoiceID;

  DeleteInvoice({this.InvoiceID});

  @override
  List<Object> get props => [];
}*/
