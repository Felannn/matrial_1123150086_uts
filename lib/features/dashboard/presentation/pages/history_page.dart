import 'package:flutter/material.dart';
import 'package:matrial_1123150086_uts/core/constants/app_colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data tiruan riwayat belanja
    final List<Map<String, dynamic>> mockHistory = [
      {
        'id': 'TRX-98301',
        'title': 'Semen Tiga Roda 50kg',
        'date': '28 Jun 2026, 04:18',
        'amount': 300000.0,
        'status': 'Selesai',
        'icon': Icons.build,
      },
      {
        'id': 'TRX-98290',
        'title': 'Batu Bata Merah (500 pcs)',
        'date': '28 Jun 2026, 04:18',
        'amount': 600000.0,
        'status': 'Selesai',
        'icon': Icons.home_repair_service,
      },
      {
        'id': 'TRX-87421',
        'title': 'Pasir Pasang Extra (1 Pick-up)',
        'date': '24 Jun 2026, 13:05',
        'amount': 750000.0,
        'status': 'Selesai',
        'icon': Icons.landscape,
      },
      {
        'id': 'TRX-75390',
        'title': 'Besi Beton 10mm (10 pcs)',
        'date': '15 Jun 2026, 09:42',
        'amount': 950000.0,
        'status': 'Selesai',
        'icon': Icons.grid_goldenratio,
      },
      {
        'id': 'TRX-61109',
        'title': 'Kuas Cat 3 Inch & Cat Tembok 5kg',
        'date': '02 Jun 2026, 16:20',
        'amount': 185000.0,
        'status': 'Selesai',
        'icon': Icons.format_paint,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: mockHistory.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_toggle_off,
                    size: 80,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum Ada Riwayat Belanja',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: mockHistory.length,
              itemBuilder: (context, index) {
                final item = mockHistory[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.primaryLight.withOpacity(0.1),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['title'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Text(
                          'Rp ${(item['amount'] as double).toStringAsFixed(0)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['date'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item['id'] as String,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Selesai',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
