import 'package:flutter/material.dart';
import 'package:auftrag_mobile/models/invoice.dart';
//import 'package:auftrag_mobile/widgets/buttons/follow_button.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  const InvoiceCard({Key key, @required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 5.0,
      ),
      child: GestureDetector(
        onTap: () {
          //Navigator.of(context).pushNamed('/profile', arguments: user.username);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).cardColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 5.0,
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(8.0),
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Theme.of(context).cardColor,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: 'sdfsdf',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Text(
                        '@',
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                  //FollowButton(user: user),
                ],
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'fdfdf',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
