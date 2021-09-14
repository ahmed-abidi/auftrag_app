import 'package:auftrag_mobile/services/search_api_client.dart';

class SearchRepository {
  final SearchApiClient searchApiClient;

  SearchRepository({SearchApiClient searchApiClient})
      : searchApiClient = searchApiClient ?? SearchApiClient();

  Future searchInvoice(String query) async {
    return searchApiClient.searchInvoice(query);
  }

  Future searchOrders(String query) async {
    return searchApiClient.searchOrders(query);
  }
}
