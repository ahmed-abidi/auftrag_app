import 'package:auftrag_mobile/models/invoice.dart';
import 'package:auftrag_mobile/services/invoice_api_client.dart';

class InvoiceRepository {
  final InvoiceApiClient invoiceApiClient;

  InvoiceRepository({InvoiceApiClient invoiceApiClient})
      : invoiceApiClient = invoiceApiClient ?? InvoiceApiClient();

  Future<List<Invoice>> getInvoices() async {
    return invoiceApiClient.fetchInvoices();
  }

  /*Future showinvoicedetail(int id) async {
    return invoiceApiClient.showInvoice(id);
  }*/
}
