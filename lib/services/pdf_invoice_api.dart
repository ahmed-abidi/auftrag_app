import 'dart:io';
import 'dart:typed_data';
import 'package:auftrag_mobile/services/pdf_api.dart';
import 'package:auftrag_mobile/models/invoice_detail.dart';
import 'package:auftrag_mobile/models/supplier.dart';
import 'package:auftrag_mobile/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<Font> fontstyletext() async {
    final font = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");

    var ttf = Font.ttf(font);

    return ttf;
  }

  static var fontpdf = fontstyletext();

  static Future<File> generate(Invoicedetail invoice) async {
    final font = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");

    var ttf = Font.ttf(font);
    var myStyle = TextStyle(font: ttf);
    final pdf = pw.Document(
        theme: pw.ThemeData(
      defaultTextStyle: myStyle,
    ));

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(),
    ));

    return PdfApi.saveDocument(name: 'Rechnung.pdf', pdf: pdf);
  }

  static Widget buildTitle(Invoicedetail invoicedata) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rechnung' + invoicedata.id.toString(),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoicedata.id.toString()),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildHeader(Invoicedetail invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: invoice.orders.first.partners.first.first_name +
                        '' +
                        invoice.orders.first.partners.first.last_name),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice),
              buildInvoiceInfo(invoice),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Invoicedetail invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('kunde name:'),
          Text(invoice.orders.first.customername ?? 'null',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('kunde name:'),
          Text(invoice.orders.first.customerlastname ?? 'null',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('address:' + invoice.orders.first.address ?? 'null'),
        ],
      );

  static Widget buildInvoiceInfo(Invoicedetail info) {
    //final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Rechnungsnummer:',
      'Partner name:',
      'Partner lastname:',
      'Geburtstermin:'
    ];
    final data = <String>[
      info.id.toString() ?? 'null',
      info.orders.first.partners.first.first_name ?? 'null',
      info.orders.first.partners.first.last_name ?? 'null',
      info.orders.first.end_date ?? 'null',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(
          Supplier supplier, Invoicedetail invoice) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address),
        ],
      );

  static Widget buildInvoice(Invoicedetail invoice) {
    final headers = [
      'Datum',
      'Order Nr.',
      'Brutto',
      'Netto',
      'Prov %',
      'CPL',
      'Betrag'
    ];
    final data = invoice.orders.map((item) {
      return [
        item.end_date ?? 'null',
        item.id ?? 'null',
        item.totalprice.toString() + '€' ?? 'null',
        item.totalpricenet.toString() + '€' ?? 'null',
        item.percent ?? 'null',
        item.partner_fees ?? 'null',
        item.totalincludprice.toString() + '€' ?? 'null'
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoicedetail invoice) {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: Text('Nettobetrag',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ))),
                      pw.Text(
                        Utils.formatPrice(double.parse(invoice.price))
                                    .toString() +
                                '€' ??
                            "",
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: Text('zzgl. 19% MWst.',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ))),
                      pw.Text(
                        Utils.formatPrice(double.parse(invoice.brute_price))
                                    .toString() +
                                '€' ??
                            "null",
                      )
                    ],
                  ),
                ),
                Divider(),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: Text('Gesamtbetrag Brutto',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ))),
                      pw.Text(
                        Utils.formatPrice(double.parse(invoice.brut_price))
                                    .toString() +
                                '€' ??
                            "null",
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(
              title:
                  'Bitte überweisen Sie die offenen Positione, auf das unten genannte Konto.',
              value: ''),
          buildSimpleText(
              title: 'Kontoinhaber   Mohamed EL-Mallouki', value: ''),
          buildSimpleText(title: 'Kreditinstitut   Solaris bank', value: ''),
          buildSimpleText(
              title: 'IBAN   DE87 1101 0100 2993 2993 20', value: ''),
          buildSimpleText(title: 'BIC   SOBKDEBBXXX', value: ''),
        ],
      );

  static buildSimpleText({
    String title,
    String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    String title,
    String value,
    double width = double.infinity,
    bool unite = false,
    pw.TextStyle style,
  }) {
    final myStyle = pw.TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          pw.Text(value, style: unite ? style : style)
        ],
      ),
    );
  }
}
