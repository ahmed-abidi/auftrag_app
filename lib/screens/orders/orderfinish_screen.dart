import 'dart:async';

import 'package:animations/animations.dart';
import 'package:auftrag_mobile/utils/helpers.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';

import 'package:auftrag_mobile/blocs/order/order_bloc.dart';

import 'package:auftrag_mobile/services/order_api_client.dart';

import 'package:auftrag_mobile/models/order.dart';

import 'package:auftrag_mobile/utils/utils.dart';

import 'orders_screen.dart';

class Orderfinish {
  String date;
  String method;
  // ignore: non_constant_identifier_names
  String matrial_price;
  String price;

  // ignore: non_constant_identifier_names
  Orderfinish({this.date, this.method, this.matrial_price, this.price});

  static List<Orderfinish> getOrders() {
    return orders;
  }

  // ignore: non_constant_identifier_names
  static addorder(date, matrial_price, price) {
    var order = new Orderfinish();
    order.date = date;
    order.matrial_price = matrial_price;
    orders.add(order);
  }
}

List<Orderfinish> orders = [];

class OrderfinishScreen extends StatefulWidget {
  Orderfinish order;
  final Order orderr;
  final int orderid;

  OrderfinishScreen({Key key, this.order, this.orderr, this.orderid})
      : super(key: key);

  @override
  _OrderfinishScreenState createState() => _OrderfinishScreenState();
}

class _OrderfinishScreenState extends State<OrderfinishScreen>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate;
  AnimationController _animationController;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  int finish;

  OrderApiClient orderapi = new OrderApiClient();

  String _myActivity;
  String _myActivityResult;

  List<Orderfinish> orders;
  List<Orderfinish> selectedorders;
  bool sort;
  GlobalKey<ScaffoldState> _scaffoldKey;

  // this list will hold the filtered employees

  Orderfinish orderfinish;
  bool _isUpdating;
  String _titleProgress;

  Orderfinish _selectedEmployee;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _material_priceController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController timeinput = TextEditingController();

  @override
  void initState() {
    timeinput.text = ""; //set the initial value of text field

    super.initState();
    sort = false;
    selectedorders = [];
    orders = Orderfinish.getOrders();

    _isUpdating = false;
    _myActivity = '';
    _myActivityResult = '';

    focusNode.addListener(() {
      focusNode.unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
//      focusNode.
    });

    _scaffoldKey = GlobalKey();
    // key to get the context to show a SnackBar
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _addorder() {
    if (_dateController.text.isEmpty ||
        _material_priceController.text.isEmpty ||
        _priceController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    setState(() {
      _myActivityResult = _myActivity;
    });
    _showProgress('Adding order...');
    var order = new Orderfinish();
    order.date = _dateController.text;
    order.method = _myActivityResult;
    order.matrial_price = _material_priceController.text;
    order.price = _priceController.text;
    orders.add(order);
    setState(() {});

    print(orders);

    //_getEmployees(orders); // Refresh the List after adding each employee...
    _clearValues();
  }

  /*deleteSelected() async {
    setState(() {
      if (selectedUsers.isNotEmpty) {
        List<User> temp = [];
        temp.addAll(selectedUsers);
        for (User user in temp) {
          users.remove(user);
          selectedUsers.remove(user);
        }
      }
    });
  }*/

  _deleteEmployee(orders) {
    _showProgress('Deleting Employee...');
  }

  _setValues(Orderfinish orderfinish) {
    _dateController.text = orderfinish.date as String;
    _priceController.text = orderfinish.price;
    _material_priceController.text = orderfinish.matrial_price;

    setState(() {
      _isUpdating = true;
    });
  }

  _clearValues() {
    _dateController.text = '';
    _priceController.text = '';
    _material_priceController.text = '';
  }

  _showValues(Orderfinish orderfinish) {
    _dateController.text = orderfinish.date as String;
    _material_priceController.text = orderfinish.matrial_price;
    _priceController.text = orderfinish.price;
  }

  showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 35,
          horizontalMargin: 2,
          columns: [
            DataColumn(
              label: Text('Zahlungsart'),
            ),
            DataColumn(
              label: Text('Datum'),
            ),
            DataColumn(
              label: Text('matriel_parice'),
            ),
            DataColumn(
              label: Text('Preis'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('löschen'),
            )
          ],
          // the list should show the filtered list now
          rows: orders
              .map(
                (orderfinish) => DataRow(cells: [
                  DataCell(
                    Text(orderfinish.method),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(orderfinish);
                      // Set the Selected employee to Update
                      _selectedEmployee = orderfinish;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(orderfinish.date),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(orderfinish);
                      // Set the Selected employee to Update
                      _selectedEmployee = orderfinish;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      orderfinish.matrial_price,
                    ),
                    onTap: () {
                      _showValues(orderfinish);
                      // Set the Selected employee to Update
                      // _selectedEmployee = orderfinish;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      orderfinish.price,
                    ),
                    onTap: () {
                      _showValues(orderfinish);
                      // Set the Selected employee to Update
                      _selectedEmployee = orderfinish;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        orders.remove(orderfinish);
                      });
                    },
                  ))
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  static Widget buildTotal(
      Orderfinish item, List<Orderfinish> orders, BuildContext context) {
    if (orders.length > 0) {
      final netTotal = orders
          .map((item) =>
              double.parse(item.price) - double.parse(item.matrial_price))
          .reduce((item1, item2) => item1 + item2);

      //final vatPercent = invoice.items.first.vat;
      final vat = netTotal * 0.19;
      final total = netTotal - vat;

      return Container(
        margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            Spacer(flex: 1),
            Expanded(
              flex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: <Widget>[
                    Text('Gesamt Netto:',
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontFamily: 'Fontawesome',
                            fontWeight: FontWeight.normal)),
                    Text(Utils.formatPrice(total) ?? 0) //Overflow!!
                  ]),
                  Row(children: <Widget>[
                    Text('MwSt:',
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontFamily: 'Fontawesome',
                            fontWeight: FontWeight.normal)),
                    Text(' 19%') //Overflow!!
                  ]),
                  Row(children: <Widget>[
                    Text('Gesamt :',
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontFamily: 'Fontawesome',
                            fontWeight: FontWeight.normal)),
                    Text(Utils.formatPrice(netTotal) ?? 0) //Overflow!!
                  ])
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            Spacer(flex: 1),
            Expanded(
              flex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: <Widget>[
                    Text('Gesamt Netto:',
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontFamily: 'Fontawesome',
                            fontWeight: FontWeight.normal)),
                    Text('0') //Overflow!!
                  ]),
                  Row(children: <Widget>[
                    Text('MwSt:',
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontFamily: 'Fontawesome',
                            fontWeight: FontWeight.normal)),
                    Text(' 19%') //Overflow!!
                  ]),
                  Row(children: <Widget>[
                    Text('Gesamt :',
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontFamily: 'Fontawesome',
                            fontWeight: FontWeight.normal)),
                    Text('0') //Overflow!!
                  ]),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    final order = ModalRoute.of(context).settings.arguments as Order;

    return Scaffold(
        appBar: AppBar(
          title: Text('Bestellung beenden'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(children: <Widget>[
                  Card(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5, horizontal: 1.0),
                          margin: EdgeInsets.all(2.0),
                          child: ListView(shrinkWrap: true, children: [
                            TextFormField(
                              controller: _material_priceController,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.money),
                                  labelText: 'Preis von Material'),
                              onTap: () {},
                            ),
                            TextFormField(
                              controller: _priceController,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.money),
                                  labelText: 'Gesamtpreis'),
                              onTap: () {},
                            ),
                            TextFormField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.calendar_today),
                                  labelText: 'datiert'),
                              onTap: () {
                                _selectDate(context);
                              },
                            ),
                            Row(children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: DropdownButton<String>(
                                  dropdownColor: Colors.white,
                                  value: _myActivity.isNotEmpty
                                      ? _myActivity
                                      : null,
                                  //elevation: 5,
                                  style: TextStyle(color: Colors.black),

                                  items: <String>[
                                    'Bargeld',
                                    'Bankkart',
                                    'überweisung',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    "Bitte wähle eine",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      _myActivity = value;
                                    });
                                  },
                                ),
                              ),
                            ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _addorder();
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    onSurface: Colors.grey,
                                    padding: EdgeInsets.all(2.0),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      // borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Hinzufugen',
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            _dataBody(),
                            buildTotal(orderfinish, orders, context),
                            _finishButton(context)
                          ]))),
                ])),
          ]),
        ));
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

  Widget _finishButton(BuildContext context) {
    final order = ModalRoute.of(context).settings.arguments as Order;
    if (orders.length > 0) {
      final netTotal = orders
          .map((item) =>
              double.parse(item.price) - double.parse(item.matrial_price))
          .reduce((item1, item2) => item1 + item2);
      final netTotalprice = orders
          .map((item) => double.parse(item.price))
          .reduce((item1, item2) => item1 + item2);

      final totalmatriel = orders
          .map((item) => double.parse(item.matrial_price))
          .reduce((item1, item2) => item1 + item2);
      var method = methodorder(orders.first.method);

      return TextButton(
        onPressed: () async {
          if (order.status == "confirmed") {
            var result = await orderapi.finish(order.id, method,
                orders.first.date, netTotalprice, totalmatriel);
            context.read<OrderBloc>().add(RefreshOrder());

            _finishDialog(context);
            orders.clear();
            setState(() {
              finish = result;
            });
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => new OrdersScreen(
                scaffoldKey: null,
              ),
            ));
          } else if (finish == 200) {
            _finsihdorder(context);
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          onSurface: Colors.grey,
          padding: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          'Erledigen',
          style: Theme.of(context).textTheme.button,
        ),
      );
    } else {
      return TextButton(
        onPressed: () async {},
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          onSurface: Colors.grey,
          padding: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          'Erledigen',
          style: Theme.of(context).textTheme.button,
        ),
      );
    }
  }

  void _finishDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('fertige Bestellung'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Bestellung ist fertig'),
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

  void _finsihdorder(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bestellung endet'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Bestellung schon fertig'),
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
