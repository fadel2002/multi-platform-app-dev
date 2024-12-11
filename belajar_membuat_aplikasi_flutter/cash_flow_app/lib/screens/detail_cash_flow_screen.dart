import 'package:cash_flow_app/models/cash_flow.dart';
import 'package:cash_flow_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../components/build_app_bar.dart';

class DetailCashFlowScreen extends StatelessWidget {
  final CashFlow cashFlow;

  const DetailCashFlowScreen({super.key, required this.cashFlow});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Detail Cash Flow"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cashFlow.shortDescription,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Type: ${cashFlow.type}",
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                Text(
                  formatDate(cashFlow.date),
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
            const Divider(height: 32, color: Colors.grey),
            const Text(
              "Amount",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              formatToIDR(cashFlow.amount),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: cashFlow.type == "income" ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              cashFlow.longDescription,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}