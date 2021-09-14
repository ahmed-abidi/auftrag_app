import 'package:auftrag_mobile/screens/orders/orderdetail_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:auftrag_mobile/models/order.dart';
import 'package:auftrag_mobile/utils/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auftrag_mobile/blocs/order/order_bloc.dart';
import 'package:intl/intl.dart';
import 'package:auftrag_mobile/blocs/order/order_bloc.dart';
import 'package:auftrag_mobile/services/order_api_client.dart';
//import 'package:auftrag_mobile/screens/photo_view_screen.dart';
//import 'package:auftrag_mobile/utils/helpers.dart';
//import 'package:auftrag_mobile/widgets/buttons/add_reply_button.dart';
//import 'package:auftrag_mobile/widgets/buttons/like_dislike_buttons.dart';
import 'package:auftrag_mobile/widgets/modals/order_actions_modal.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  //final GlobalKey<ScaffoldState> scaffoldKey;
  // DateTime now = DateTime.now();
  // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

  const OrderCard({
    Key key,
    this.order,
    /*this.scaffoldKey*/
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderApiClient orderapi = new OrderApiClient();
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).canvasColor,
            offset: Offset(10, 10),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: InkWell(
              onTap: () => {
                if (order.status == "accepted" ||
                    order.status == "confirmed" ||
                    order.status == "finished " ||
                    order.status == "paid_customer")
                  {
                    /* Navigator.of(context)
                        .pushNamed('/orderdetail', arguments: order)*/
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderdetailScreen(order: order))),
                  }
                else if (order.status == "rejected")
                  {_reject(context)}
                else if (order.status == "cancelled")
                  {_cancled(context)}
                else
                  {
                    AlertDialog(
                      title: const Text('AlertDialog Title'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Bestellung wird nicht angenommen'),
                            Text('klicke auf den Akzeptieren-Button'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Approve'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  }
              },
              child: CircleAvatar(
                radius: 25.0,
                /*backgroundImage: NetworkImage(
                  order.user.avatar,
                )*/
                child: mapchangestatus(order.status),
                backgroundColor: Theme.of(context).cardColor,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () => {
                    if (order.status == "accepted" ||
                        order.status == "confirmed" ||
                        order.status == "finished" ||
                        order.status == "paid_customer")
                      {
                        /*Navigator.of(context)
                            .pushNamed('/orderdetail', arguments: order)*/
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OrderdetailScreen(order: order))),
                      }
                    else if (order.status == "rejected")
                      {_reject(context)}
                    else if (order.status == "cancelled")
                      {_cancled(context)}
                    else
                      {_acceptDialog(context)}
                  },
                  child: Container(
                    width: size.width / 1.93,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.service_name,
                          style: Theme.of(context).textTheme.caption,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          //"@${order.status}",
                          status(order.status),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Text(
                              'Stadt:',
                              style: Theme.of(context).textTheme.bodyText2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Text(order.city ?? 'null'),
                          ),
                        ]),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Text(
                                  'Straße:',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Text(order.street ?? 'null'))
                          ],
                        )

                        /*Row(children: [
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Text(
                              'Stadt:',
                              style: Theme.of(context).textTheme.bodyText2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Text(order.city ?? 'null'),
                          ),
                          Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Text(
                                'Straße:',
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              )),
                          Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Text(order.street ?? 'null'))
                        ])*/
                      ],
                    ),
                  ),
                ),
                Text(
                  timeago.format(order.createdAt, locale: 'en_short'),
                  style: Theme.of(context).textTheme.bodyText2,
                ),

                /*IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  color: Theme.of(context).textSelectionTheme.cursorColor,
                  onPressed: () =>
                      OrderActionsModal().mainBottomSheet(context, order),
                ),*/
              ],
            ),
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                //"@${order.status}",
                "Anfangsdatum",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                //"@${order.status}",
                status(order.start_date),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                //"@${order.status}",
                "Startzeit",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                //"@${order.status}",
                status(order.start_time),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),*/
          Divider(
            color: Colors.grey[300],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(90.0, 0.0, 50.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(

                    //width: MediaQuery.of(context).size.width / 3,
                    child: TextButton(
                  onPressed: () async {
                    if (order.status == "affected") {
                      await orderapi.accept(order.id);
                      context.read<OrderBloc>().add(
                            RefreshOrder(),
                          );
                    } else if (order.status == "rejected") {
                      _reject(context);
                    } else if (order.status == "cancelled") {
                      _cancled(context);
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    onSurface: Colors.grey,
                    padding: EdgeInsets.all(2.0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'akzeptieren',
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                )),
                Container(width: 5, color: Colors.transparent),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if (order.status == "affected") {
                        orderapi.reject(order.id);
                        context.read<OrderBloc>().add(
                              RefreshOrder(),
                            );
                      } else if (order.status == "rejected") {
                        _reject(context);
                      } else if (order.status == "cancelled") {
                        _cancled(context);
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      onSurface: Colors.grey,
                      padding: EdgeInsets.all(2.0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'ablehnen',
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _acceptDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bestellung annehmen'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Bestellung wird nicht angenommen'),
                  Text('klicke auf den Akzeptieren-Button'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Genehmigen'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _rejectDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bestellung ablehnen'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Sie werden die Bestellung sicher ablehnen'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Abbrechen'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('bestätigen'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _reject(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bestellung ablehnen'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Bestellung wurde bereits abgelehnt'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Genehmigen'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _cancled(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bestellung storniert'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Die Bestellung wurde bereits storniert'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Genehmigen'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
