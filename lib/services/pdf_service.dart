import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import '../database/daos/bill_dao.dart';

/// Generates bill PDFs with plumber's header, line items, and total
class PdfService {
  /// Generates a PDF bill and returns the File
  static Future<File> generateBillPdf({
    required BillWithItems billData,
    required String ownerName,
    required String ownerPhone,
  }) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('dd/MM/yyyy');
    final billDate = dateFormat.format(
      DateTime.fromMillisecondsSinceEpoch(billData.bill.createdAt),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header — plumber's name and phone
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      ownerName,
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Phone: $ownerPhone',
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Plumbing & Core Cutting Services',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 16),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 16),

              // Bill info row
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Bill No: ${billData.bill.billNumber}',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Date: $billDate'),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Customer:',
                          style: const pw.TextStyle(color: PdfColors.grey700)),
                      pw.Text(billData.customer.name,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(billData.customer.phone),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 24),

              // Items table
              pw.TableHelper.fromTextArray(
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: const pw.BoxDecoration(
                  color: PdfColors.grey200,
                ),
                cellPadding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                cellAlignments: {
                  0: pw.Alignment.center,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.center,
                  3: pw.Alignment.centerRight,
                  4: pw.Alignment.centerRight,
                },
                headers: ['Sr.', 'Description', 'Qty', 'Rate (₹)', 'Amount (₹)'],
                data: List<List<String>>.generate(
                  billData.items.length,
                  (index) {
                    final item = billData.items[index];
                    return [
                      '${index + 1}',
                      item.itemName,
                      item.quantity.toStringAsFixed(item.quantity == item.quantity.roundToDouble() ? 0 : 1),
                      item.unitPrice.toStringAsFixed(2),
                      item.total.toStringAsFixed(2),
                    ];
                  },
                ),
              ),

              pw.SizedBox(height: 16),
              pw.Divider(),

              // Grand total
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Text(
                    'Grand Total: ₹${billData.bill.totalAmount.toStringAsFixed(2)}',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),

              pw.SizedBox(height: 8),

              // Payment status
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  billData.bill.isPaid ? 'PAID ✓' : 'PAYMENT PENDING',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: billData.bill.isPaid ? PdfColors.green700 : PdfColors.red700,
                  ),
                ),
              ),

              pw.Spacer(),

              // Footer
              pw.Center(
                child: pw.Text(
                  'Thank you for your business!',
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    // Save to temp directory
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/bill_${billData.bill.billNumber}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
