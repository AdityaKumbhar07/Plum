import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Handles WhatsApp sharing (deep links for text, share sheet for files)
class ShareService {
  /// Share a PDF file via native share sheet (user picks WhatsApp)
  static Future<void> sharePdfFile(File file, {String? text}) async {
    await Share.shareXFiles(
      [XFile(file.path)],
      text: text,
    );
  }

  /// Send a text message to a specific phone number via WhatsApp deep link
  /// Phone must be in international format without '+' (e.g., 919999999999)
  static Future<bool> sendWhatsAppMessage({
    required String phone,
    required String message,
  }) async {
    // Add India country code if not present
    String formattedPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (formattedPhone.length == 10) {
      formattedPhone = '91$formattedPhone';
    }

    final url = Uri.parse(
      'https://wa.me/$formattedPhone?text=${Uri.encodeComponent(message)}',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      return true;
    }
    return false;
  }

  /// Format a quotation as a clean WhatsApp text message
  static String formatQuotationText({
    required String customerName,
    required List<Map<String, dynamic>> items,
    required String ownerName,
    required String ownerPhone,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('📋 *साहित्य यादी / Materials List*');
    buffer.writeln('━━━━━━━━━━━━━━━━━━');
    buffer.writeln('ग्राहक: $customerName');
    buffer.writeln('');

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final qty = item['quantity'] as double;
      final unit = item['unit'] as String? ?? '';
      final qtyStr = qty == qty.roundToDouble()
          ? qty.toInt().toString()
          : qty.toStringAsFixed(1);
      buffer.writeln(
        '${i + 1}. ${item['name']} — $qtyStr ${unit.isNotEmpty ? unit : 'nos'}',
      );
    }

    buffer.writeln('');
    buffer.writeln('━━━━━━━━━━━━━━━━━━');
    buffer.writeln('From: $ownerName');
    buffer.writeln('📞 $ownerPhone');

    return buffer.toString();
  }

  /// Format a payment reminder message in Marathi
  static String formatReminderMessage({
    required String customerName,
    required double amount,
    required String ownerName,
  }) {
    return 'नमस्कार $customerName!\n\n'
        'तुमच्या ₹${amount.toStringAsFixed(0)} बाकी रकमेसाठी हे स्मरणपत्र आहे.\n'
        'कृपया लवकरात लवकर रक्कम चुकती करा.\n\n'
        'धन्यवाद!\n'
        '$ownerName';
  }
}
