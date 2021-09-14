import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auftrag_mobile/blocs/order/order_bloc.dart';

class NotificationButton extends StatefulWidget {
  final Color bubbleColor;
  final Icon icon;

  NotificationButton({Key key, this.bubbleColor, this.icon}) : super(key: key);

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  @override
  void initState() {
    context.read<OrderBloc>().add(FetchOrder());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.icon,
        BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoaded) {
              return Positioned(
                left: 11.0,
                top: 0.0,
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                    color: widget.bubbleColor != null
                        ? widget.bubbleColor
                        : Colors.white.withOpacity(.4),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );
            }
            return Container(height: 0, width: 0);
          },
        )
      ],
    );
  }
}
