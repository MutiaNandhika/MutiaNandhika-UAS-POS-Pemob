import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/DashboardController.dart';
import '../../widgets/custom_sidebar.dart';
import '../../widgets/chart_widgets.dart';


class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.purple,
      ),
      drawer: const CustomDrawer(selectedIndex: 0), // Drawer dengan selectedIndex 0
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryCards(),
            const SizedBox(height: 16),
            _buildWeeklyChart(),
            const SizedBox(height: 16),
            _buildTopProducts(),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildSummaryCards() {
    return Column(
      children: [
        Obx(() => _buildSummaryCard(
              'Today\'s Sales',
              'Rp ${controller.todayTotal.value.toStringAsFixed(0)}',
              Icons.monetization_on,
              Colors.orange,
            )),
        const SizedBox(height: 12),
        Obx(() => _buildSummaryCard(
              'Transactions',
              '${controller.transactionCount.value}',
              Icons.receipt_long,
              Colors.yellow,
            )),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Sales',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GetBuilder<DashboardController>(
            builder: (controller) {
              return controller.weeklyData.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : WeeklyBarChart(data: controller.weeklyData);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTopProducts() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Products',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GetBuilder<DashboardController>(
            builder: (controller) {
              if (controller.topProducts.isEmpty ||
                  controller.topProductSales.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: List.generate(controller.topProducts.length, (index) {
                  return ListTile(
                    leading: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.primaries[index % Colors.primaries.length],
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      controller.topProducts[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Rp ${controller.topProductSales[index].toStringAsFixed(0)}',
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}