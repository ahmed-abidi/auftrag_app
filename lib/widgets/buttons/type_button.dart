/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:tweety_mobile/blocs/auth_profile/auth_profile_bloc.dart';
import 'package:auftrag_mobile/blocs/order/order_bloc.dart';
import 'package:auftrag_mobile/models/Order.dart';

class TypeButton extends StatefulWidget {
  final Order order;
  TypeButton({Key key, @required this.order}) : super(key: key);

  @override
  _TypeButtonState createState() => _TypeButtonState();
}

class _TypeButtonState extends State<TypeButton> {
  //bool get _isFollowed => widget.order.status;
  //set _isFollowed(bool isFollowed) => widget.user.isFollowed = isFollowed;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is Followed) {
          context
              .read<orderBloc>()
              .add(ReloadAuthProfile(user: state.user));
        }
        if (state is Unfollowed) {
          context
              .read<AuthProfileBloc>()
              .add(ReloadAuthProfile(user: state.user));
        }
      },
      child: _isFollowed ? _unfollowButton() : _followButton(),
    );
  }

  Widget _followButton() {
    return TextButton(
      onPressed: () {
        _follow();
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
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
        'Follow',
        style: Theme.of(context).textTheme.button.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }

  Widget _unfollowButton() {
    return TextButton(
      onPressed: () {
        _unfollow();
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
        'Following',
        style: Theme.of(context).textTheme.button,
      ),
    );
  }

  void _follow() async {
    HapticFeedback.mediumImpact();
    context.read<FollowBloc>().add(FollowUser(user: widget.user));
    setState(() {
      _isFollowed = true;
    });
  }

  void _unfollow() async {
    HapticFeedback.mediumImpact();
    context.read<FollowBloc>().add(UnfollowUser(user: widget.user));
    setState(() {
      _isFollowed = false;
    });
  }
}*/