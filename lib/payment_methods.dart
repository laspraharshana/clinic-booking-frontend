import 'package:clinic_booking_frontend/patient_profile.dart';
import 'package:flutter/material.dart';
import 'package:clinic_booking_frontend/brand_colors.dart' hide kPrimaryDark;

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final List<Map<String, String>> methods = [
    {'brand': 'Visa', 'last4': '4242'},
  ];

  void _addMethod() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add payment method'),
        content: const Text('Implement card form or wallet adding here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: kPrimaryDark)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        backgroundColor: kPrimaryDark,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addMethod,
        backgroundColor: kPrimaryDark,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, i) {
          final m = methods[i];
          return ListTile(
            leading: const Icon(Icons.credit_card, color: kPrimaryDark),
            title: Text('${m['brand']} •••• ${m['last4']}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => setState(() => methods.removeAt(i)),
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemCount: methods.length,
      ),
    );
  }
}