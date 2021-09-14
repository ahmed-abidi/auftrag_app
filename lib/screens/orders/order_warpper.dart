/*import 'package:auftrag_mobile/models/orderdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auftrag_mobile/blocs/order/order_bloc.dart';
import 'package:auftrag_mobile/utils/helpers.dart';
import 'package:auftrag_mobile/widgets/buttons/avatar_button.dart';
import 'package:auftrag_mobile/widgets/loading_indicator.dart';
import 'package:auftrag_mobile/widgets/refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrderScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const OrderScreen({Key key, @required this.scaffoldKey})
      : super(key: key);
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final double targetElevation = 20.0;
  double _elevation = 0;
  ScrollController _scrollController;

  @override
  void initState() {
    context.read<OrderBloc>().add(FetchOrder());

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
            'orders',
            style: Theme.of(context).appBarTheme.textTheme.caption,
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoading) {
                  return LoadingIndicator();
                }
                if (state is OrderLoaded) {
                  return state.orders.length > 0
                      ? ListView.separated(
                          controller: _scrollController,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10.0);
                          },
                          itemCount: state.orders.length,
                          itemBuilder: (context, index) {
                            var order = state.orders[index];
                            return InkWell(
                              onTap: order.id != null
                                  ? () {
                                      Navigator.of(context).pushNamed(
                                          Orderdetail(),
                                          arguments: order.id);
                                    }
                                  : () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: order.createdAt == null
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
                                      mapNotificationTypeToIcon(
                                          order.status),
                                      SizedBox(width: 15.0),
                                      Flexible(
                                        child: Container(
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
                                                        notification.data
                                                            .notifier.avatar),
                                                    fit: BoxFit.contain,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                              Text(order.service_name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption),
                                              SizedBox(height: 5.0),
                                              Text(
                                                timeago.format(
                                                    order.createdAt),
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
                            "No notifications yet",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        );
                }
                if (state is NotificationError) {
                  return Refresh(
                    title: 'Error fetching notifications!',
                    onPressed: () {
                      context.read<NotificationBloc>().add(
                            FetchNotifications(),
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
}*/
