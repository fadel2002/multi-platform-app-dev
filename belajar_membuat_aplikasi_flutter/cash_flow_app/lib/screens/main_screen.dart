import 'dart:math';

import 'package:cash_flow_app/screens/all_cash_flow_screen.dart';
import 'package:cash_flow_app/components/build_app_bar.dart';
import 'package:cash_flow_app/screens/detail_cash_flow_screen.dart';
import 'package:cash_flow_app/models/cash_flow.dart';
import 'package:cash_flow_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../components/build_drawer_items.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 820) {
          return Scaffold(
            appBar: buildAppBar("Cash Flow App"),
            body: const SingleChildScrollView(
              child: MainScreenAndroid(),
            ),
            drawer: buildDrawerItems(context),
          );
        } else if (constraints.maxWidth <= 1200)  {
          return Scaffold(
            appBar: buildAppBar("Cash Flow App"),
            body: const SingleChildScrollView(
              child: MainScreenWeb(),
            ),
            drawer: buildDrawerItems(context),
          );
        } else {
          return Scaffold(
            appBar: buildAppBar("Cash Flow App"),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 250,
                  color: Colors.blue[800],
                  child: buildDrawerItems(context),
                ),
                const Expanded(
                  child: SingleChildScrollView(
                    child: MainScreenWeb(),
                  ),
                ),
              ],
            ),
          );
        }
      },
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
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
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
                        return const AllCashFlowScreen();
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
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6)
          ),
          margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Recent Income",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                height:1.0,
                color: Colors.black,
              ),
              CashFlowList(cashFlowList: sortRecent(cashFlowIncome)),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6)
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Recent Expense",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                height:1.0,
                color: Colors.black,
              ),
              CashFlowList(cashFlowList: sortRecent(cashFlowExpense)),
            ],
          ),
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
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetailCashFlowScreen(cashFlow: cashFlow)
            ));
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
                      Text(formatDate(cashFlow.date)),
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
  const MainScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Recent Income",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        height:1.0,
                        color: Colors.black,
                      ),
                      CashFlowList(cashFlowList: sortRecent(cashFlowIncome)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Recent Expense",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        height:1.0,
                        color: Colors.black,
                      ),
                      CashFlowList(cashFlowList: sortRecent(cashFlowExpense)),
                    ],
                  ),
                ),
              ],
            ),
        ),
        Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(6)
              ),
              margin: const EdgeInsets.only(right: 8.0, top: 8.0),
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Center(
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "All Summary",
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Balance"),
                            Text(formatToIDR(totalIncome - totalExpense)),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Income"),
                            Text(formatToIDR(totalIncome)),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Expense"),
                            Text(formatToIDR(totalExpense)),
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
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const AllCashFlowScreen()
                          ));
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
            )
        ),
      ],
    );
  }
}