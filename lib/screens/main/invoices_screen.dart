import 'package:auftrag_mobile/models/invoice.dart';
import 'package:auftrag_mobile/services/invoice_api_client.dart';
import 'package:auftrag_mobile/services/pdf_invoice_api.dart';
import 'package:auftrag_mobile/services/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auftrag_mobile/blocs/invoice/invoice_bloc.dart';
import 'package:auftrag_mobile/utils/helpers.dart';
import 'package:auftrag_mobile/models/invoice_detail.dart';
import 'package:auftrag_mobile/models/invoice.dart';
import 'package:auftrag_mobile/widgets/buttons/avatar_button.dart';
import 'package:auftrag_mobile/widgets/loading_indicator.dart';
import 'package:auftrag_mobile/widgets/refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

class InvoicesScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const InvoicesScreen({Key key, @required this.scaffoldKey}) : super(key: key);
  @override
  _InvoicesScreenState createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  InvoiceApiClient invoiceapi = new InvoiceApiClient();
  final double targetElevation = 20.0;
  double _elevation = 0;
  ScrollController _scrollController;
  Invoice invoice;

  List<Invoice> invoices;

  Invoicedetail invoicedetail;

  @override
  void initState() {
    context.read<InvoiceBloc>().add(FetchInvoice());

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double newElevation = _scrollController.offset > 1 ? targetElevation : 0;
    if (_elevation != newElevation) {
      setState(() {
        _elevation = newElevation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) return false;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Theme.of(context).textSelectionTheme.cursorColor,
          ),
          leading: AvatarButton(
            scaffoldKey: widget.scaffoldKey,
          ),
          title: Text(
            'Rechnungen',
            style: Theme.of(context).appBarTheme.textTheme.caption,
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: BlocBuilder<InvoiceBloc, InvoiceState>(
              builder: (context, state) {
                if (state is InvoiceLoading) {
                  return SliverFillRemaining(
                    child: LoadingIndicator(),
                  );
                }
                if (state is InvoiceLoaded) {
                  return state.invoices.length > 0
                      ? ListView.separated(
                          controller: _scrollController,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10.0);
                          },
                          itemCount: state.invoices.length,
                          itemBuilder: (context, index) {
                            var invoice = state.invoices[index];
                            return InkWell(
                              onTap: () async {
                                invoicedetail =
                                    await invoiceapi.showInvoice(invoice.id);
                                //invoiceapi.showInvoicetest(invoice.id);
                                _generatevoice(invoicedetail);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: invoice == null
                                      ? Theme.of(context).splashColor
                                      : Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).canvasColor,
                                        offset: Offset(0, 10),
                                        blurRadius: 10.0)
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(width: 10.0),
                                      CircleAvatar(
                                        radius: 25.0,
                                        child: Icon(Icons.payments_sharp,
                                            size: 40, color: Color(0xFF00ACC1)),
                                        backgroundColor:
                                            Theme.of(context).cardColor,
                                      ),
                                      SizedBox(width: 15.0),
                                      Flexible(
                                        child: Container(
                                          //margin:const EdgeInsets.only(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 30.0,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        invoice.status),
                                                    fit: BoxFit.contain,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                        statusinvoice(invoice
                                                                .status) ??
                                                            'null',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption),
                                                  ]),
                                              Text(
                                                timeago
                                                    .format(invoice.createdAt),
                                                style: TextStyle(
                                                    color: Colors.grey[700]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: Text(
                            "Noch keine Benachrichtigungen",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        );
                }
                if (state is InvoiceError) {
                  return Refresh(
                    title: 'Fehler beim Abrufen von Benachrichtigungen!',
                    onPressed: () {
                      context.read<InvoiceBloc>().add(
                            FetchInvoice(),
                          );
                    },
                  );
                }
                return Container();
              },
            )),
      ),
    );
  }

  Future<void> _generatevoice(Invoicedetail invoice) async {
    final pdfFile = await PdfInvoiceApi.generate(invoice);

    PdfApi.openFile(pdfFile);
  }
}
