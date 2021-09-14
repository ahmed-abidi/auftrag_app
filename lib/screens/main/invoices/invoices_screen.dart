/*import 'dart:async';

import 'package:auftrag_mobile/models/invoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auftrag_mobile/blocs/invoice/invoice_bloc.dart';
//import 'package:auftrag_mobile/screens/orders/order_wrapper.dart';
import 'package:auftrag_mobile/widgets/buttons/avatar_button.dart';
import 'package:auftrag_mobile/widgets/loading_indicator.dart';
import 'package:auftrag_mobile/widgets/refresh.dart';
import 'package:auftrag_mobile/widgets/cards/invoice_card.dart';

class InvoicesScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  InvoicesScreen({Key key, @required this.scaffoldKey}) : super(key: key);

  @override
  _InvoicesScreenState createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  List<Invoice> invoices;
  Completer<void> _ordersRefreshCompleter;

  @override
  void initState() {
    super.initState();
    context.read<InvoiceBloc>().add(
          FetchInvoice(),
        );

    _scrollController.addListener(_onScroll);
    _ordersRefreshCompleter = Completer<void>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      context.read<InvoiceBloc>().add(
            FetchInvoice(),
          );
    }
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocListener<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          if (state is InvoiceLoaded) {
            _ordersRefreshCompleter?.complete();
            _ordersRefreshCompleter = Completer();
          }
        },
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 1.0,
          onRefresh: () {
            context.read<InvoiceBloc>().add(
                  RefreshInvoice(),
                );
            return _ordersRefreshCompleter.future;
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 20.0,
                floating: true,
                iconTheme: IconThemeData(
                  color: Theme.of(context).textSelectionTheme.cursorColor,
                ),
                leading: AvatarButton(
                  scaffoldKey: widget.scaffoldKey,
                ),
                title: Text(
                  "Rechnungen",
                ),
                centerTitle: true,
              ),
              BlocBuilder<InvoiceBloc, InvoiceState>(
                builder: (context, state) {
                  if (state is InvoiceLoading) {
                    return SliverFillRemaining(
                      child: LoadingIndicator(),
                    );
                  }
                  if (state is InvoiceLoaded) {
                    invoices = state.invoices;
                    if (state.invoices.isEmpty) {
                      return SliverFillRemaining(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "No orders yet!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            " you'll see their orders here.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ));
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => index >= invoices.length
                            ? LoadingIndicator()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 5.0,
                                ),
                                child: GestureDetector(
                                  child: InvoiceCard(
                                    invoice: invoices[index],
                                    /*scaffoldKey: widget.scaffoldKey,*/
                                  ),
                                ),
                              ),
                        childCount: state.hasReachedMax
                            ? state.invoices.length
                            : state.invoices.length + 1,
                      ),
                    );
                  }
                  if (state is InvoiceError) {
                    return SliverToBoxAdapter(
                      child: Container(
                        child: Refresh(
                          title: 'Bestellungen konnten nicht geladen werden',
                          onPressed: () {
                            context.read<InvoiceBloc>().add(
                                  RefreshInvoice(),
                                );
                          },
                        ),
                      ),
                    );
                  }
                  return SliverFillRemaining(
                    child: LoadingIndicator(size: 21.0),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
