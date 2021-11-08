import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auftrag_mobile/preferences/preferences.dart';

Icon mapNotificationTypeToIcon(String type) {
  Icon icon;
  switch (type) {
    case "App\\Notifications\\YouWereFollowed":
      icon = Icon(Icons.person_add, color: Color(0xFF4299E1));
      break;
    case "App\\Notifications\\YouWereMentioned":
      icon = Icon(Icons.alternate_email, color: Color(0xFF9F7AEA));
      break;
    case "App\\Notifications\\RecentlyTweeted":
      icon = Icon(Icons.note_add, color: Color(0xFF38B2AC));
      break;
    case "App\\Notifications\\TweetWasLiked":
      icon = Icon(Icons.thumb_up, color: Color(0xFF3182CE));
      break;
    case "App\\Notifications\\TweetWasDisliked":
      icon = Icon(Icons.thumb_down, color: Color(0xFFF56565));
      break;

    case "App\\Notifications\\ReceivedNewReply":
      icon = Icon(Icons.comment, color: Color(0xFF667EEA));
      break;
  }

  return icon;
}

Icon mapchangestatus(String status) {
  Icon icon;
  switch (status) {
    case "affected":
      icon = Icon(Icons.info, size: 60, color: Color(0xFF00ACC1));
      break;
    case "confirmed":
      icon = Icon(Icons.info, size: 60, color: Color(0xFF8E24AA));
      break;
    case "paid_customer":
      icon = Icon(Icons.info, size: 60, color: Color(0xFF00C853));
      break;
    case "paid_partner":
      icon = Icon(Icons.info, size: 60, color: Color(0xFF00C853));
      break;  
    case "cancelled":
      icon = Icon(Icons.info, size: 60, color: Color(0xFFC62828));
      break;
    case "accepted":
      icon = Icon(Icons.info, size: 60, color: Color(0xFFFFEB3B));
      break;

    case "rejected":
      icon = Icon(Icons.info, size: 60, color: Color(0xFF37474F));
      break;
  }

  return icon;
}

String status(String status) {
  switch (status) {
    case "affected":
      status = "zugesendet";
      break;
    case "confirmed":
      status = "Bestätigt";
      break;
    case "paid_customer":
      status = "bezahlter_kunde";
      break;
    case "paid_partner":
      status = "partner_kunde";
      break;  
    case "finished":
      status = "Erledigt";
      break;
    case "accepted":
      status = "angenommen";
      break;

    case "rejected":
      status = "abgelehnt";
      break;

    case "cancelled":
      status = "Storniert";
      break;
  }

  return status;
}

String statusinvoice(String status) {
  switch (status) {
    case "unpaid":
      status = "unbezahlt";
      break;
    case "paid_customer":
      status = "bezahlter_kunde";
      break;
    case "paid_partner":
      status = "bezahlter_partner";
      break;
    case "partner_customer":
      status = "partner_kunde";
      break;
    case "transfer":
      status = "Transfer";
      break;

    case "double_pay":
      status = "doppelt zahlen";
      break;
  }

  return status;
}

String methodorder(String method) {
  switch (method) {
    case "Bargeld":
      method = "cash";
      break;
    case "Bankkarte":
      method = "card";
      break;
    case "Überweisung":
      method = "transfer";
      break;
  }

  return method;
}

List<String> parseBody(String body) {
  final RegExp exp = RegExp(
    r'<a[^>]*>([^<]+)<\/a>',
  );

  var matches = exp.allMatches(body);

  for (var match in matches) {
    body = body.replaceAll(match.group(0), match.group(1));
  }

  List<String> stringList = body.split(" ");

  return stringList;
}

TextSpan bodyTextSpan(String body, BuildContext context, TextStyle style) {
  return TextSpan(
      text: body + " ",
      style: body.trim().startsWith('@')
          ? style.copyWith(color: Theme.of(context).primaryColor)
          : style,
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          if (body.trim().startsWith('@')) {
            Navigator.of(context).pushNamed('/profil',
                arguments: body.trim().replaceFirst('@', ''));
          }
        });
}

String formatCount(int count) {
  return NumberFormat.compactCurrency(
    decimalDigits: 0,
    symbol: '',
  ).format(count);
}

bool isCurrentUser(int userId) {
  int currentUserId = Prefer.prefs.getInt('userID');
  return currentUserId == userId;
}

int authId() {
  return Prefer.prefs.getInt('userID');
}
