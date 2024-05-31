import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ValidateBarcodeScreen extends StatelessWidget {
  final TextEditingController barcodeController = TextEditingController();

  ValidateBarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validate Barcode'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: barcodeController,
              decoration: const InputDecoration(labelText: 'Enter Barcode'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final barcode = barcodeController.text;
                final isValid =
                    await Provider.of<AuthProvider>(context, listen: false)
                        .validateBarcode(barcode);
                final message = isValid
                    ? 'Barcode is valid'
                    : 'Barcode is invalid or already used';
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              },
              child: const Text('Validate'),
            ),
          ],
        ),
      ),
    );
  }
}
