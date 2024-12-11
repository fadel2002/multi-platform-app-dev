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
  CashFlow(
    amount: 450000,
    type: "expense",
    date: "2024-12-11",
    longDescription: "Subscription payment for streaming services.",
    shortDescription: "Streaming Subscription",
  ),
  CashFlow(
    amount: 1200000,
    type: "income",
    date: "2024-12-12",
    longDescription: "Bonus payment from the company.",
    shortDescription: "Company Bonus",
  ),
  CashFlow(
    amount: 250000,
    type: "expense",
    date: "2024-12-13",
    longDescription: "Purchase of office supplies.",
    shortDescription: "Office Supplies",
  ),
  CashFlow(
    amount: 200000,
    type: "expense",
    date: "2024-12-14",
    longDescription: "Maintenance fee for car repair.",
    shortDescription: "Car Repair",
  ),
  CashFlow(
    amount: 6000000,
    type: "income",
    date: "2024-12-15",
    longDescription: "Freelance payment for a graphic design project.",
    shortDescription: "Freelance Design",
  ),
  CashFlow(
    amount: 320000,
    type: "expense",
    date: "2024-12-16",
    longDescription: "Purchase of new shoes.",
    shortDescription: "Shoes",
  ),
  CashFlow(
    amount: 1500000,
    type: "income",
    date: "2024-12-17",
    longDescription: "Selling pre-owned gadgets.",
    shortDescription: "Gadget Sale",
  ),
  CashFlow(
    amount: 500000,
    type: "expense",
    date: "2024-12-18",
    longDescription: "Expense for family dinner.",
    shortDescription: "Family Dinner",
  ),
  CashFlow(
    amount: 1000000,
    type: "income",
    date: "2024-12-19",
    longDescription: "Refund for a returned product.",
    shortDescription: "Product Refund",
  ),
  CashFlow(
    amount: 700000,
    type: "expense",
    date: "2024-12-20",
    longDescription: "Mobile phone bill payment.",
    shortDescription: "Phone Bill",
  ),
  CashFlow(
    amount: 100000,
    type: "expense",
    date: "2024-12-21",
    longDescription: "Expense for coffee with friends.",
    shortDescription: "Coffee",
  ),
  CashFlow(
    amount: 1500000,
    type: "income",
    date: "2024-12-22",
    longDescription: "Part-time income for tutoring.",
    shortDescription: "Tutoring",
  ),
  CashFlow(
    amount: 350000,
    type: "expense",
    date: "2024-12-23",
    longDescription: "Purchase of household cleaning supplies.",
    shortDescription: "Cleaning Supplies",
  ),
  CashFlow(
    amount: 900000,
    type: "expense",
    date: "2024-12-24",
    longDescription: "Expense for a holiday trip.",
    shortDescription: "Holiday Trip",
  ),
  CashFlow(
    amount: 2500000,
    type: "income",
    date: "2024-12-25",
    longDescription: "Year-end bonus from employer.",
    shortDescription: "Year-End Bonus",
  ),
  CashFlow(
    amount: 600000,
    type: "expense",
    date: "2024-12-26",
    longDescription: "Gift purchase for a friend.",
    shortDescription: "Gift",
  ),
  CashFlow(
    amount: 1800000,
    type: "income",
    date: "2024-12-27",
    longDescription: "Payment from a second-hand furniture sale.",
    shortDescription: "Furniture Sale",
  ),
  CashFlow(
    amount: 400000,
    type: "expense",
    date: "2024-12-28",
    longDescription: "Monthly gym membership fee.",
    shortDescription: "Gym Membership",
  ),
  CashFlow(
    amount: 150000,
    type: "expense",
    date: "2024-12-29",
    longDescription: "Taxi fare for commuting to work.",
    shortDescription: "Taxi",
  ),
  CashFlow(
    amount: 1000000,
    type: "income",
    date: "2024-12-30",
    longDescription: "Lottery winnings.",
    shortDescription: "Lottery",
  ),
];

var cashFlowIncome = cashFlowList.where((cashFlow) => cashFlow.type == "income").toList();

var cashFlowExpense = cashFlowList.where((cashFlow) => cashFlow.type == "expense").toList();

var totalIncome = cashFlowIncome.fold(0, (sum, cashFlow) => sum + cashFlow.amount);

var totalExpense = cashFlowExpense.fold(0, (sum, cashFlow) => sum + cashFlow.amount);

