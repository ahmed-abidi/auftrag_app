import 'dart:async';

import 'package:animations/animations.dart';
import 'package:auftrag_mobile/models/order.dart';
import 'package:auftrag_mobile/repositories/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auftrag_mobile/blocs/order/order_bloc.dart';
import 'package:auftrag_mobile/services/order_api_client.dart';
//import 'package:auftrag_mobile/screens/orders/order_wrapper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auftrag_mobile/services/order_api_client.dart';
import 'package:auftrag_mobile/widgets/buttons/avatar_button.dart';
import 'package:auftrag_mobile/models/order.dart';
import 'package:auftrag_mobile/widgets/loading_indicator.dart';
import 'package:auftrag_mobile/widgets/refresh.dart';
import 'package:auftrag_mobile/widgets/cards/order_card.dart';

import 'orderfinish_screen.dart';

class OrderdetailScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Order order;
  final int orderid;
  OrderdetailScreen({
    Key key,
    this.order,
    this.orderid,
    @required this.scaffoldKey,
  }) : super(key: key);

  @override
  _OrderdetailScreenState createState() => _OrderdetailScreenState();
}

class _OrderdetailScreenState extends State<OrderdetailScreen> {
  DateTime _selectedDate;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String _hour, _minute, _time;
  int confirm;

  OrderApiClient orderapi = new OrderApiClient();

  TextEditingController _reasonController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<OrderBloc>().add(Ordershow(OrderID: widget.order.id));
    context.read<OrderBloc>().add(RefreshOrder());
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
      });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    //final order = ModalRoute.of(context).settings.arguments as Order;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Bestelldetails'),
        ),
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Card(
                      child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        Padding(
                            padding: EdgeInsets.all(15.0),
                            child: IconButton(
                              icon: Icon(Icons.person, color: Colors.black54),
                              onPressed: () {},
                            )),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.customer.firstname ?? '',
                                style: Theme.of(context).textTheme.caption,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Name",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.customer.lastname ?? '',
                                  style: Theme.of(context).textTheme.caption,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Nachname",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ))
                      ]) /*ListTile(
                          title: Text(order.customer.firstname),
                          //Text(order.customer.lastname)
                          subtitle: Text(
                            "Name",
                            style: TextStyle(color: Colors.black54),
                          ),
                          leading: IconButton(
                            icon: Icon(Icons.person, color: Colors.black54),
                            onPressed: () {},
                          ))*/

                      ),
                  Card(
                      child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        Padding(
                            padding: EdgeInsets.all(15.0),
                            child: IconButton(
                              icon:
                                  Icon(Icons.date_range, color: Colors.black54),
                              onPressed: () {},
                            )),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.start_date ?? 'null',
                                style: Theme.of(context).textTheme.caption,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Anfangsdatum",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.end_date ?? 'null',
                                  style: Theme.of(context).textTheme.caption,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Endtermin",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ))
                      ])),
                  Card(
                      child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        Padding(
                            padding: EdgeInsets.all(15.0),
                            child: IconButton(
                              icon: Icon(Icons.timer, color: Colors.black54),
                              onPressed: () {},
                            )),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.start_time ?? 'null',
                                style: Theme.of(context).textTheme.caption,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Startzeit",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.end_time ?? 'null',
                                  style: Theme.of(context).textTheme.caption,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Endzeit",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ))
                      ])),
                  Card(
                    child: ListTile(
                      title: Text(widget.order.customer.phone ?? 'null'),
                      subtitle: Text(
                        "Telefone",
                        style: TextStyle(color: Colors.black54),
                      ),
                      leading: IconButton(
                        icon: Icon(Icons.phone, color: Colors.black54),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(widget.order.customer.email ?? 'null'),
                      subtitle: Text(
                        "E-mail",
                        style: TextStyle(color: Colors.black54),
                      ),
                      leading: IconButton(
                          icon: Icon(Icons.email, color: Colors.black54),
                          onPressed: () {}),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(widget.order.address ?? 'null'),
                      subtitle: Text(
                        "Adresse",
                        style: TextStyle(color: Colors.black54),
                      ),
                      leading: IconButton(
                          icon: Icon(Icons.share, color: Colors.black54),
                          onPressed: () {}),
                    ),
                  ),
                  Card(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(child: _confirmeButton(context)),
                      Expanded(child: _FinichButton(context)),
                      Expanded(child: _cancalButton(context)),
                    ],
                  ))
                ],
              ),
            )
          ])
        ])));
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _dateController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _dateController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  Widget _confirmeButton(BuildContext context) {
    //final order = ModalRoute.of(context).settings.arguments as Order;
    return TextButton(
      onPressed: () {
        if (widget.order.status == "confirmed" ||
            widget.order.status == "finished " ||
            widget.order.status == "paid_customer" ||
            confirm == 200) {
          confirmedorder(context);
        } else if (widget.order.status == "cancelled") {
          cancledorder(context);
        } else {
          _confirmDialog(context);
        }
      },
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        onSurface: Colors.grey,
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        'Bestätigt',
        style: Theme.of(context).textTheme.button,
      ),
    );
  }

  Widget _FinichButton(BuildContext context) {
    //final order = ModalRoute.of(context).settings.arguments as Order;
    return TextButton(
      onPressed: () {
        //Navigator.of(context).pushNamed('/orderfinish', arguments: order);
        if (confirm == 200) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => new OrderfinishScreen(),
              settings: RouteSettings(
                arguments: widget.order,
              )));
        } else if (widget.order.status == "confirmed") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => new OrderfinishScreen(),
              settings: RouteSettings(
                arguments: widget.order,
              )));
        } else if (widget.order.status == "cancelled") {
          cancledorder(context);
        } else if (widget.order.status == "paid_customer" ||
            widget.order.status == "finished") {
          finsihdorder(context);
        }
      },
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        onSurface: Colors.grey,
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        'Erledigen',
        style: Theme.of(context).textTheme.button,
      ),
    );
  }

  Widget _cancalButton(BuildContext context) {
    //final order = ModalRoute.of(context).settings.arguments as Order;
    return TextButton(
      onPressed: () {
        if (widget.order.status == "confirmed" || confirm == 200) {
          _cancelmDialog(context);
        } else if (widget.order.status == "cancelled") {
          cancledorder(context);
        }
      },
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        onSurface: Colors.grey,
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        'stornieren',
        style: Theme.of(context).textTheme.button,
      ),
    );
  }

  /* Widget _fromconfirm(BuildContext context) {
    return Form(
      key: _formKey,
    );
  }*/

  Future<void> _confirmDialog(context) async {
    //final order = ModalRoute.of(context).settings.arguments as Order;
    return showModal<void>(
        context: context,
        configuration: FadeScaleTransitionConfiguration(),
        builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text(
              'Bestellung bestätigen',
              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
            ),
            content: Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), labelText: 'datiert'),
                    onTap: () {
                      _selectDate(context);
                    },
                  ),
                  TextFormField(
                      controller: _timeController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.timer), labelText: 'Zeit'),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () {
                        _selectTime(context);
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child:
                            Text('Schliessen', style: TextStyle(fontSize: 15)),
                      ),
                      TextButton(
                          onPressed: () async {
                            var date = _dateController.text;
                            var time = _timeController.text;
                            if (date != '' && time != '') {
                              var result = await orderapi.confirm(
                                  widget.order.id, date, time);

                              setState(() {
                                confirm = result;
                              });
                            }
                            context.read<OrderBloc>().add(RefreshOrder());

                            Navigator.pop(context);
                          },
                          child:
                              Text('Speichern', style: TextStyle(fontSize: 15)))
                    ],
                  )
                ],
              ),
              height: 200,
              width: 200,
            )));
  }

  Future<void> _methodDialog(context) async {
    final order = ModalRoute.of(context).settings.arguments as Order;
    return showModal<void>(
        context: context,
        configuration: FadeScaleTransitionConfiguration(),
        builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text(
              'Bestellung bestätigen',
              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
            ),
            content: Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    maxLines: 5,
                    controller: _reasonController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.text_fields), labelText: 'Grund'),
                    onTap: () {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child:
                            Text('Schliessen', style: TextStyle(fontSize: 15)),
                      ),
                      TextButton(
                          onPressed: () {
                            var reason = _reasonController.text;

                            orderapi.cancled(order.id, reason);
                            context.read<OrderBloc>().add(RefreshOrder());
                            Navigator.pop(context);
                          },
                          child:
                              Text('Speichern', style: TextStyle(fontSize: 15)))
                    ],
                  )
                ],
              ),
              height: 200,
              width: 200,
            )));
  }

  Future<void> _cancelmDialog(context) async {
    final order = ModalRoute.of(context).settings.arguments as Order;
    return showModal<void>(
        context: context,
        configuration: FadeScaleTransitionConfiguration(),
        builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text(
              'Bestellung bestätigen',
              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
            ),
            content: Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    maxLines: 5,
                    controller: _reasonController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.text_fields), labelText: 'Grund'),
                    onTap: () {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child:
                            Text('Schliessen', style: TextStyle(fontSize: 15)),
                      ),
                      TextButton(
                          onPressed: () {
                            var reason = _reasonController.text;

                            orderapi.cancled(order.id, reason);
                            context.read<OrderBloc>().add(RefreshOrder());
                            Navigator.pop(context);
                          },
                          child:
                              Text('Speichern', style: TextStyle(fontSize: 15)))
                    ],
                  )
                ],
              ),
              height: 200,
              width: 200,
            )));
  }

  void confirmedorder(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bestellung bestätigen'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Bestellung bereits bestätigen'),
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

  void cancledorder(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('stornierte Bestellung'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('die Bestellung wird storniert'),
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

  void finsihdorder(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bestellung endet'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Bestellung ist erfolgreich abgeschlossen'),
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
