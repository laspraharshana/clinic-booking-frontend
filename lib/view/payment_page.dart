import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:clinic_booking_frontend/core/network/dio_client.dart';
import 'test_booking_confirmed_page.dart';

class PaymentPage extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final String dateTime;
  final double totalAmount;

  // NEW inputs from BookAppointmentPage
  final String slotId;
  final String? patientName;
  final String? notes;

  const PaymentPage({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.dateTime,
    required this.totalAmount,
    required this.slotId,
    this.patientName,
    this.notes,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  String selectedMethod = "Credit/Debit Card";

  late final Dio _dio;
  bool _paying = false;
  double? _quotedTotal;
  String _currency = 'LKR';

  @override
  void initState() {
    super.initState();
    _dio = createDio();
    _loadQuote(); // optional: confirm totals from server
  }

  Future<void> _loadQuote() async {
    try {
      final res = await _dio.get('/v1/appointments/quote', queryParameters: {'slotId': widget.slotId});
      final data = Map<String, dynamic>.from(res.data['data'] as Map);
      final fee = Map<String, dynamic>.from(data['fee'] as Map);
      setState(() {
        _quotedTotal = (fee['total'] as num).toDouble();
        _currency = (fee['currency'] as String?) ?? 'LKR';
      });
    } catch (_) {/* keep UI usable */}
  }

  Future<void> _bookAppointment() async {
    if (_paying) return;
    setState(() => _paying = true);

    try {
      final res = await _dio.post('/v1/appointments/book', data: {
        'slotId': widget.slotId,
        if (widget.notes != null && widget.notes!.isNotEmpty) 'notes': widget.notes,
        if (widget.patientName != null && widget.patientName!.isNotEmpty) 'patientName': widget.patientName,
      });

      // Parse appointment from server
      final appt = Map<String, dynamic>.from((res.data as Map)['data'] as Map);
      final fee = Map<String, dynamic>.from(appt['fee'] as Map);

      if (!mounted) return;

      // Navigate to Booking Confirmed page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BookingConfirmedPage(
            appointmentId: appt['id'] as String,
            doctorName: widget.doctorName,
            specialty: widget.specialty,
            startUtc: (appt['startUtc'] as num).toInt(),
            endUtc: (appt['endUtc'] as num).toInt(),
            currency: (fee['currency'] as String? ?? 'LKR'),
            consultationFee: (fee['consultation'] as num).toDouble(),
            platformFee: (fee['platform'] as num).toDouble(),
            total: (fee['total'] as num).toDouble(),
            patientName: appt['patientName'] as String?,
            notes: appt['notes'] as String?,
          ),
        ),
      );
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      final msg = switch (code) {
        401 => 'Please sign in to book',
        404 => 'Slot not found',
        409 => 'This slot was just booked. Pick another.',
        400 => 'Slot is no longer valid',
        _ => 'Booking failed. Please try again',
      };
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Booking failed')));
      }
    } finally {
      if (mounted) setState(() => _paying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalLabel = '${_currency} ${( _quotedTotal ?? widget.totalAmount ).toStringAsFixed(0)}';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text("Payment"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Appointment Summary
          Row(children: const [Icon(Icons.receipt_outlined, size: 20), SizedBox(width: 8), Text("Appointment Summary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))]),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
            ),
            child: Column(children: [
              _summaryRow("Doctor", widget.doctorName),
              const SizedBox(height: 8),
              _summaryRow("Specialty", widget.specialty),
              const SizedBox(height: 8),
              _summaryRow("Date & Time", widget.dateTime),
              const Divider(height: 24),
              _summaryRow("Total Amount", totalLabel, isBold: true),
            ]),
          ),

          const SizedBox(height: 24),

          // Payment Method
          Row(children: const [Icon(Icons.payment, size: 20), SizedBox(width: 8), Text("Payment Method", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))]),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: DropdownButtonFormField<String>(
                value: selectedMethod,
                items: const [
                  DropdownMenuItem(value: "Credit/Debit Card", child: Text("Credit/Debit Card")),
                  DropdownMenuItem(value: "PayPal", child: Text("PayPal")),
                  DropdownMenuItem(value: "Bank Transfer", child: Text("Bank Transfer")),
                ],
                onChanged: (value) => setState(() => selectedMethod = value!),
                decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Card Details (simulated)
          Row(children: const [Icon(Icons.credit_card, size: 20), SizedBox(width: 8), Text("Card Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))]),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Cardholder Name", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
              const SizedBox(height: 8),
              TextField(controller: nameController, decoration: _inputDecoration("Enter your name")),
              const SizedBox(height: 16),
              const Text("Card Number", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
              const SizedBox(height: 8),
              TextField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("1234 5678 9012 3456").copyWith(prefixIcon: const Icon(Icons.credit_card, size: 20)),
              ),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("Expiry Date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
                  const SizedBox(height: 8),
                  TextField(controller: expiryController, decoration: _inputDecoration("MM/YY")),
                ])),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("CVV", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
                  const SizedBox(height: 8),
                  TextField(controller: cvvController, obscureText: true, keyboardType: TextInputType.number, decoration: _inputDecoration("123")),
                ])),
              ]),
            ]),
          ),

          const SizedBox(height: 24),

          // Pay button → book + navigate to confirmation
          SizedBox(
            width: double.infinity, height: 50,
            child: ElevatedButton(
              onPressed: _paying ? null : () async => _bookAppointment(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00695C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: _paying
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text("Pay ${_currency} ${( _quotedTotal ?? widget.totalAmount ).toStringAsFixed(0)}",
                  style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ]),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
      focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: Color(0xFF00695C))),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: isBold ? FontWeight.w600 : FontWeight.normal)),
        Text(value, style: TextStyle(fontSize: isBold ? 16 : 14, color: Colors.black87, fontWeight: isBold ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }
}