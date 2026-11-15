import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static Future<void> generateAndPrintResultPdf({
    required String className,
    required String examName,
    required String madrasahName,
    required String madrasahAddress,
    required int totalStudents,
    required int passed,
    required int failed,
    required double passRate,
  }) async {
    final pdf = pw.Document();

    final font = await PdfGoogleFonts.notoSansBengaliRegular();
    final boldFont = await PdfGoogleFonts.notoSansBengaliBold();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // মাদ্রাসার নাম ও হেডার ডিজাইন
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  madrasahName,
                  style: pw.TextStyle(font: boldFont, fontSize: 20, color: PdfColors.blue900),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  madrasahAddress,
                  style: pw.TextStyle(font: font, fontSize: 10, color: PdfColors.grey700),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 6),
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.blue800),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                  ),
                  child: pw.Text(
                    'OFFICIAL RESULT SUMMARY',
                    style: pw.TextStyle(font: boldFont, fontSize: 11, color: PdfColors.blue800),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 12),
            pw.Divider(thickness: 1.5, color: PdfColors.grey700),
            pw.SizedBox(height: 10),

            // পরীক্ষার তথ্য ও সামারি বক্স ডিজাইন
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey200,
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('পরীক্ষা: $examName', style: pw.TextStyle(font: boldFont, fontSize: 12)),
                      pw.SizedBox(height: 4),
                      pw.Text('শ্রেণি: $className', style: pw.TextStyle(font: font, fontSize: 11)),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('মোট শিক্ষার্থী: $totalStudents | পাস: $passed | ফেল: $failed', style: pw.TextStyle(font: font, fontSize: 11)),
                      pw.SizedBox(height: 4),
                      pw.Text('পাসের হার: ${passRate.toStringAsFixed(2)}%', style: pw.TextStyle(font: boldFont, fontSize: 12, color: PdfColors.green800)),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 50),

            // স্বাক্ষর সেকশন ডিজাইন
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Container(width: 120, child: pw.Divider(color: PdfColors.black, thickness: 1)),
                    pw.SizedBox(height: 4),
                    pw.Text('শ্রেণি শিক্ষকের স্বাক্ষর', style: pw.TextStyle(font: boldFont, fontSize: 10)),
                  ],
                ),
                pw.Column(
                  children: [
                    pw.Container(width: 120, child: pw.Divider(color: PdfColors.black, thickness: 1)),
                    pw.SizedBox(height: 4),
                    pw.Text('অধ্যক্ষ / সুপারের স্বাক্ষর', style: pw.TextStyle(font: boldFont, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: '${className}_Result_Design.pdf',
    );
  }
}