import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello PDF Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              generatePDF();
            },
            child: Text('Generate PDF'),
          ),
        ),
      ),
    );
  }

  pw.Document generatePDF() {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World!'),
          );
        },
      ),
    );

    // Save the PDF to a file
    savePDF(pdf);
    return pdf;
  }

  void savePDF(pw.Document pdf) async {
    // Example: Requesting storage permission
    PermissionStatus status = await Permission.storage.request();

    if (status == PermissionStatus.granted) {
      final output =
          await getApplicationDocumentsDirectory(); // Use getApplicationDocumentsDirectory
      final file = File("${output.path}/PDF.pdf");
      await file.writeAsBytes(await pdf.save());
      print('1');

      openPDF(file);
    } else if (status == PermissionStatus.denied) {
      // Permission was denied
      print('2');
    } else if (status == PermissionStatus.permanentlyDenied) {
      // Permission was permanently denied
      // Open app settings to let the user grant the permission manually
      print('3');
      openAppSettings();
    }
  }

  void openPDF(File file) {
    // Use a PDF viewer package or a native intent to open the PDF
    // For example, you can use the 'flutter_pdfview' package to display the PDF
  }
}
