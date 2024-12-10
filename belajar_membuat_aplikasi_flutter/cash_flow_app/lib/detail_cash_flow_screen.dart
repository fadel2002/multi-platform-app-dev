import 'package:cash_flow_app/models/cash_flow.dart';
import 'package:cash_flow_app/utils/utils.dart';
import 'package:flutter/material.dart';

import 'components/build_app_bar.dart';

class DetailCashFlowScreen extends StatelessWidget {
  final CashFlow cashFlow;

  const DetailCashFlowScreen({super.key, required this.cashFlow});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Detail Cash Flow"),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return DetailCashFlowScreenAndroid(cashFlow: cashFlow);
          } else {
            return const DetailCashFlowScreenWeb(gridCount: 4);
          }
        },
      ),
    );
  }
}

class DetailCashFlowScreenAndroid extends StatelessWidget{
  final CashFlow cashFlow;

  const DetailCashFlowScreenAndroid({super.key, required this.cashFlow});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Text(
                formatDate(cashFlow.date),
                style: const TextStyle(fontSize: 18, color: Colors.grey),
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
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
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
    );
  }
}

class DetailCashFlowScreenWeb extends StatelessWidget{
  final int gridCount;

  const DetailCashFlowScreenWeb({super.key, required this.gridCount});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}