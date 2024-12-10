import 'dart:math';

import 'package:cash_flow_app/all_cash_flow_screen.dart';
import 'package:cash_flow_app/components/build_app_bar.dart';
import 'package:cash_flow_app/detail_cash_flow_screen.dart';
import 'package:cash_flow_app/models/cash_flow.dart';
import 'package:cash_flow_app/utils/utils.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Cash Flow App"),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 600) {
              return const MainScreenAndroid();
            } else {
              return const MainScreenWeb(gridCount: 4);
            }
          },
        ),
      ),
    );
  }
}

class MainScreenAndroid extends StatelessWidget {
  const MainScreenAndroid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Background color
            border: Border.all(
              color: Colors.black,  // Border color
              width: 1.0,         // Border width
            ),
            borderRadius: BorderRadius.circular(6)
          ),
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Center(
            child: Column(
              children: [
                const Center(child:
                  Text("All Summary",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding:const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height:1.0,
                    color: Colors.black,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("Income"),
                        Text("Rp2.000.000"),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Expense"),
                        Text("700.000"),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Balance"),
                        Text("1.300.000"),
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return AllCashFlowScreen();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Show All Cash Flow',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Recent Income",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, // Background color
              border: Border.all(
                color: Colors.black,  // Border color
                width: 1.0,         // Border width
              ),
              borderRadius: BorderRadius.circular(6)
          ),
          margin: const EdgeInsets.all(8.0),
          child: CashFlowList(cashFlowList: sortRecent(cashFlowIncome)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Recent Expense",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, // Background color
              border: Border.all(
                color: Colors.black,  // Border color
                width: 1.0,         // Border width
              ),
              borderRadius: BorderRadius.circular(6)
          ),
          margin: const EdgeInsets.all(8.0),
          child: CashFlowList(cashFlowList: sortRecent(cashFlowExpense)),
        ),
      ],
    );
  }
}

class CashFlowList extends StatelessWidget {
  final List<CashFlow> cashFlowList;

  const CashFlowList({super.key, required this.cashFlowList});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: min(cashFlowList.length, 4),
      itemBuilder: (context, index){
        final CashFlow cashFlow = cashFlowList[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailCashFlowScreen();
            }));
          },
          child: Card(
            shape: const RoundedRectangleBorder(),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(cashFlow.shortDescription),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 5),
                      Text(formatToIDR(cashFlow.amount).toString()),
                      const SizedBox(height: 5),
                      Text(dateFormat(cashFlow.date)),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MainScreenWeb extends StatelessWidget {
  final int gridCount;

  const MainScreenWeb({super.key, required this.gridCount});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}