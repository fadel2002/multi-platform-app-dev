import 'package:cash_flow_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../components/build_app_bar.dart';
import '../components/build_dropdown_items.dart';
import '../screens/detail_cash_flow_screen.dart';
import '../models/cash_flow.dart';

class AllCashFlowScreen extends StatelessWidget {
  const AllCashFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("All Cash Flow"),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return const AllCashFlowScreenAndroid();
          } else {
            return const AllCashFlowScreenWeb(gridCount: 4);
          }
        },
      ),
    );
  }
}

class AllCashFlowScreenAndroid extends StatefulWidget {
  const AllCashFlowScreenAndroid({super.key});

  @override
  State<AllCashFlowScreenAndroid> createState() => _AllCashFlowScreenAndroidState();
}

class _AllCashFlowScreenAndroidState extends State<AllCashFlowScreenAndroid> {
  String _selectedType = "All";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Filter Type",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: DropdownButton<String>(
                value: _selectedType,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  }
                },
                items: buildDropdownItems(["All", "Expense", "Income"]),
                icon: const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.arrow_drop_down),
                ),
                isExpanded: true,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            child: CashFlowList(
              cashFlowList: _filterCashFlowList(_selectedType),
            ),
          ),
        ),
      ],
    );
  }

  List<CashFlow> _filterCashFlowList(String filter) {
    return sortRecent(
      filter == "All" ? cashFlowList : (
        filter == "Income" ? cashFlowIncome :
        cashFlowExpense
      ),
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
      itemCount: cashFlowList.length,
      itemBuilder: (context, index){
        final CashFlow cashFlow = cashFlowList[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailCashFlowScreen(cashFlow: cashFlow);
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

class AllCashFlowScreenWeb extends StatelessWidget{
  final int gridCount;

  const AllCashFlowScreenWeb({super.key, required this.gridCount});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

