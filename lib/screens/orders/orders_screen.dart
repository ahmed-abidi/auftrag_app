import 'dart:async';

import 'package:auftrag_mobile/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auftrag_mobile/blocs/order/order_bloc.dart';
//import 'package:auftrag_mobile/screens/orders/order_wrapper.dart';
import 'package:auftrag_mobile/widgets/buttons/avatar_button.dart';
import 'package:auftrag_mobile/widgets/loading_indicator.dart';
import 'package:auftrag_mobile/widgets/refresh.dart';
import 'package:auftrag_mobile/widgets/cards/order_card.dart';

class OrdersScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  OrdersScreen({Key key, @required this.scaffoldKey}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  List<Order> orders;
  Completer<void> _ordersRefreshCompleter;

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(
          FetchOrder(),
        );
    context.read<OrderBloc>().add(RefreshOrder());

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
      context.read<OrderBloc>().add(
            FetchOrder(),
          );
    }
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderLoaded) {
            _ordersRefreshCompleter?.complete();
            _ordersRefreshCompleter = Completer();
          }
        },
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 1.0,
          onRefresh: () {
            context.read<OrderBloc>().add(
                  RefreshOrder(),
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
                  color: Colors.lightBlueAccent,
                  //Theme.of(context).textSelectionTheme.cursorColor,
                ),
                leading: AvatarButton(
                  scaffoldKey: widget.scaffoldKey,
                ),
                title: Text(
                  "Auftrag",
                ),
                centerTitle: true,
              ),
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return SliverFillRemaining(
                      child: LoadingIndicator(),
                    );
                  }
                  if (state is OrderLoaded) {
                    orders = state.orders;
                    if (state.orders.isEmpty) {
                      return SliverFillRemaining(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Noch keine Bestellungen!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "Sie sehen ihre Bestellungen hier.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ));
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => index >= orders.length
                            ? LoadingIndicator()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 5.0,
                                ),
                                child: GestureDetector(
                                  child: OrderCard(
                                    order: orders[index],
                                    /*scaffoldKey: widget.scaffoldKey,*/
                                  ),
                                ),
                              ),
                        childCount: state.hasReachedMax
                            ? state.orders.length
                            : state.orders.length + 1,
                      ),
                    );
                  }
                  if (state is OrderError) {
                    return SliverToBoxAdapter(
                      child: Container(
                        child: Refresh(
                          title: 'Bestellungen konnten nicht geladen werden',
                          onPressed: () {
                            context.read<OrderBloc>().add(
                                  RefreshOrder(),
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
}
