import 'package:flutter/material.dart';
import 'admin_navbar.dart';
// import 'admin_doctors_page.dart';
// import 'admin_patients_page.dart';
// import 'admin_appointments_page.dart';
// import 'admin_reports_page.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildDashboardContent(),
      // const AdminDoctorsPage(),
      // const AdminAppointmentsPage(),
      // const AdminReportsPage(),
      const Center(child: Text("Settings Page")),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_currentIndex]),
      bottomNavigationBar: AdminNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }

  // -------------------- DASHBOARD CONTENT --------------------
  Widget _buildDashboardContent() {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(child: _buildHeader()),

          // Stats Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.4,
              ),
              delegate: SliverChildListDelegate([
                _buildStatCard(
                  'Total Doctors',
                  '156',
                  Icons.people_outline,
                  const Color(0xFFE3F2FD),
                  const Color(0xFF2196F3),
                ),
                _buildStatCard(
                  'Total Patients',
                  '3,842',
                  Icons.person_outline,
                  const Color(0xFFE0F7FA),
                  const Color(0xFF00BCD4),
                ),
                _buildStatCard(
                  'Appointments',
                  '284',
                  Icons.calendar_today_outlined,
                  const Color(0xFFF3E5F5),
                  const Color(0xFF9C27B0),
                ),
                _buildStatCard(
                  'Earnings',
                  '\$12.4K',
                  Icons.payments_outlined,
                  const Color(0xFFFFF9C4),
                  const Color(0xFFFFC107),
                ),
              ]),
            ),
          ),

          // Quick Actions
          SliverToBoxAdapter(child: _buildQuickActions()),

          // Recent Appointments
          SliverToBoxAdapter(child: _buildRecentAppointments()),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  // -------------------- HEADER --------------------
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 18, 151, 109),
            Color.fromARGB(255, 16, 72, 67),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Welcome back, Admin',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.settings_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- STATS GRID --------------------
  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                Center(
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- QUICK ACTIONS --------------------
  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildActionCard(
                'Add Doctor',

                Icons.person_add_outlined,
                const Color(0xFFE3F2FD),
                const Color(0xFF2196F3),
              ),
              _buildActionCard(
                'View Patients',
                Icons.visibility_outlined,
                const Color(0xFFE0F7FA),
                const Color(0xFF00BCD4),
              ),
              _buildActionCard(
                'Appointments',
                Icons.event_note_outlined,
                const Color(0xFFF3E5F5),
                const Color(0xFF9C27B0),
              ),
              _buildActionCard(
                'Reports',
                Icons.trending_up_outlined,
                const Color(0xFFFFEBEE),
                const Color(0xFFF44336),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color bgColor,
    Color iconColor,
  ) {
    return GestureDetector(
      onTap: () {
        if (title == 'Add Doctor') {
          // Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminDoctorsPage()));
        } else if (title == 'View Patients') {
          // Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminPatientsPage()));
        } else if (title == 'Appointments') {
          // Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminAppointmentsPage()));
        } else if (title == 'Reports') {
          // Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminReportsPage()));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 15),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- RECENT APPOINTMENTS --------------------
  Widget _buildRecentAppointments() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Appointments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => const AdminAppointmentsPage()),
                  // );
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF0D7377),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAppointmentItem(
            'Sarah Johnson',
            'Dr. Smith',
            '10:30 AM',
            'confirmed',
            Colors.green,
          ),
          _buildAppointmentItem(
            'Mike Chen',
            'Dr. Williams',
            '11:45 AM',
            'pending',
            Colors.orange,
          ),
          _buildAppointmentItem(
            'Emily Davis',
            'Dr. Brown',
            '02:15 PM',
            'confirmed',
            Colors.green,
          ),
          _buildAppointmentItem(
            'James Wilson',
            'Dr. Jones',
            '04:00 PM',
            'canceled',
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem(
    String patientName,
    String doctorName,
    String time,
    String status,
    Color statusColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doctorName,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  status == 'confirmed'
                      ? Icons.check_circle
                      : status == 'pending'
                      ? Icons.pending
                      : Icons.cancel,
                  size: 14,
                  color: statusColor,
                ),
                const SizedBox(width: 4),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
