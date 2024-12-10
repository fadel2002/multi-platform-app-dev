class CashFlow {
  int amount;
  String type;
  String date;
  String longDescription;
  String shortDescription;

  CashFlow({
    required this.amount,
    required this.type,
    required this.date,
    required this.longDescription,
    required this.shortDescription,
  });
}

var cashFlowList = <CashFlow>[
  CashFlow(
    amount: 5000000,
    type: "income",
    date: "2024-12-01",
    longDescription: "Salary payment for the month of December.",
    shortDescription: "Salary",
  ),
  CashFlow(
    amount: 2000000,
    type: "expense",
    date: "2024-12-02",
    longDescription: "Monthly electricity bill payment.",
    shortDescription: "Electricity Bill",
  ),
  CashFlow(
    amount: 300000,
    type: "expense",
    date: "2024-12-03",
    longDescription: "Grocery shopping for the week.",
    shortDescription: "Grocery",
  ),
  CashFlow(
    amount: 1500000,
    type: "income",
    date: "2024-12-04",
    longDescription: "Freelance income for website development.",
    shortDescription: "Freelance Income",
  ),
  CashFlow(
    amount: 1200000,
    type: "expense",
    date: "2024-12-05",
    longDescription: "Payment for dining at a restaurant.",
    shortDescription: "Dining",
  ),
  CashFlow(
    amount: 800000,
    type: "expense",
    date: "2024-12-06",
    longDescription: "Monthly internet service bill payment.",
    shortDescription: "Internet Bill",
  ),
  CashFlow(
    amount: 500000,
    type: "expense",
    date: "2024-12-07",
    longDescription: "Expense for transportation to work.",
    shortDescription: "Transportation",
  ),
  CashFlow(
    amount: 2500000,
    type: "income",
    date: "2024-12-08",
    longDescription: "Refund from a previous overpayment on utility bills.",
    shortDescription: "Refund",
  ),
  CashFlow(
    amount: 7000000,
    type: "income",
    date: "2024-12-09",
    longDescription: "Investment income from stocks.",
    shortDescription: "Investment Income",
  ),
  CashFlow(
    amount: 600000,
    type: "expense",
    date: "2024-12-10",
    longDescription: "Shopping for new clothes.",
    shortDescription: "Shopping",
  ),
];

var cashFlowIncome = cashFlowList.where((cashFlow) => cashFlow.type == "income").toList();

var cashFlowExpense = cashFlowList.where((cashFlow) => cashFlow.type == "expense").toList();
