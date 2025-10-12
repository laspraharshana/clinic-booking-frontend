import 'package:flutter/material.dart';

// Brand colors
const kPrimaryDark = Color(0xFF1B5E57);
const kPrimary = Color(0xFF00695C);

class BookingConfirmedPage extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String hospital;
  final DateTime dateTime;
  final double totalPaid; // amount in LKR

  // Use initializer list for DateTime default (more compatible across SDKs)
  BookingConfirmedPage({
    super.key,
    this.doctorName = 'Dr. Michael Chen',
    this.specialty = 'Neurology',
    this.hospital = 'Available Hospital',
    DateTime? dateTime,
    this.totalPaid = 205, // LKR amount
  }) : dateTime = dateTime ?? DateTime(2025, 10, 12, 16, 0);

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    final timeStr =
        '${(dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12).toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'PM' : 'AM'}';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              const _Header(),
              const SizedBox(height: 8),

              // Doctor + details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _DoctorCard(
                  doctorName: doctorName,
                  specialty: specialty,
                  hospital: hospital,
                  date: dateStr,
                  time: timeStr,
                  // Display as LKR
                  totalPaidText: 'LKR ${totalPaid.toStringAsFixed(0)}',
                ),
              ),

              // QR card
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _QrCard(
                  onSave: () => _toast(context, 'QR saved (demo)'),
                  onShare: () => _toast(context, 'Share sheet opened (demo)'),
                ),
              ),

              // What's Next card
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: _WhatsNextCard(),
              ),

              // Buttons
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => _toast(context, 'Go to My Appointments'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'View My Appointments',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.home_outlined),
                    label: const Text('Back to Home'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: kPrimaryDark),
    );
  }
}

// ================= Header =================

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryDark, kPrimary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          Positioned(top: 20, right: -20, child: _circle(80, Colors.white.withOpacity(0.08))),
          Positioned(top: 70, left: 16, child: _circle(36, Colors.white.withOpacity(0.10))),
          Positioned(bottom: 10, left: 80, child: _circle(50, Colors.white.withOpacity(0.06))),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 8),
                _SuccessBadge(),
                SizedBox(height: 12),
                Text(
                  'Booking Confirmed!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Your appointment has been successfully\nbooked',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _circle(double size, Color color) =>
      Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

class _SuccessBadge extends StatelessWidget {
  const _SuccessBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: const Center(child: Icon(Icons.check_circle, color: Colors.white, size: 32)),
    );
  }
}

// ================= Doctor + details card =================

class _DoctorCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String hospital;
  final String date;
  final String time;
  final String totalPaidText; // already formatted "LKR 205"

  const _DoctorCard({
    required this.doctorName,
    required this.specialty,
    required this.hospital,
    required this.date,
    required this.time,
    required this.totalPaidText,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doctorName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 2),
          Text(specialty, style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFE9F7EE), borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 14),
                const SizedBox(width: 4),
                Text(hospital,
                    style: const TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.w700, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _DetailRow(icon: Icons.calendar_today_outlined, label: 'Date', value: date),
          const SizedBox(height: 8),
          _DetailRow(icon: Icons.access_time_outlined, label: 'Time', value: time),
          const SizedBox(height: 8),
          _DetailRow(icon: Icons.paid_outlined, label: 'Total Paid', value: totalPaidText),
        ],
      ),
    );
  }
}

// ================= QR card =================

class _QrCard extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onShare;

  const _QrCard({required this.onSave, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Appointment QR Code', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87)),
          const SizedBox(height: 12),
          Center(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFF2F4F7), borderRadius: BorderRadius.circular(18)),
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(color: const Color(0xFFEAECEF), borderRadius: BorderRadius.circular(14)),
                child: const _FakeQr(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              'Show this QR code at the clinic or use for online consultation',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onSave,
                  icon: const Icon(Icons.save_alt),
                  label: const Text('Save'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kPrimaryDark,
                    side: const BorderSide(color: kPrimaryDark),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onShare,
                  icon: const Icon(Icons.ios_share),
                  label: const Text('Share'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kPrimaryDark,
                    side: const BorderSide(color: kPrimaryDark),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ================= What's Next card =================

class _WhatsNextCard extends StatelessWidget {
  const _WhatsNextCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("What's Next?", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87)),
          SizedBox(height: 10),
          _InfoBullet(text: "You'll receive a confirmation SMS and email shortly"),
          _InfoBullet(text: "Arrive 15 minutes early at the hospital with your QR code"),
          _InfoBullet(text: "You can reschedule or cancel up to 2 hours before your appointment"),
        ],
      ),
    );
  }
}

// ===== Reusable sub-widgets =====

class _CardShell extends StatelessWidget {
  final Widget child;
  const _CardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: child,
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54, size: 18),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: Colors.black87)),
          const Spacer(),
          Text(value, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _InfoBullet extends StatelessWidget {
  final String text;
  const _InfoBullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 5), child: Icon(Icons.circle, size: 6, color: Color(0xFF1976D2))),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: Color(0xFF1E3A5F), height: 1.35))),
        ],
      ),
    );
  }
}

// Very small fake QR painter (no dependency)
class _FakeQr extends StatelessWidget {
  const _FakeQr();

  @override
  Widget build(BuildContext context) {
    const int rows = 9;
    const int cols = 9;
    final List<List<bool>> pattern = List.generate(
      rows,
      (r) => List.generate(cols, (c) {
        final inTL = r < 3 && c < 3;
        final inTR = r < 3 && c > cols - 4;
        final inBL = r > rows - 4 && c < 3;
        final diag = (r + c) % 3 == 0;
        return inTL || inTR || inBL || diag;
      }),
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: AspectRatio(
        aspectRatio: 1,
        child: LayoutBuilder(
          builder: (_, c) {
            final cell = c.maxWidth / cols;
            return CustomPaint(painter: _QrPainter(pattern: pattern, cellSize: cell));
          },
        ),
      ),
    );
  }
}

class _QrPainter extends CustomPainter {
  final List<List<bool>> pattern;
  final double cellSize;

  _QrPainter({required this.pattern, required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF2C2C2C);
    for (int r = 0; r < pattern.length; r++) {
      for (int c = 0; c < pattern[r].length; c++) {
        if (pattern[r][c]) {
          final rect = Rect.fromLTWH(c * cellSize, r * cellSize, cellSize * 0.75, cellSize * 0.75);
          canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(1.5)), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _QrPainter oldDelegate) =>
      oldDelegate.pattern != pattern || oldDelegate.cellSize != cellSize;
}