import 'package:intl/intl.dart';

import '../models/cash_flow.dart';

enum ScreenType {
  WEB,
  ANDROID,
}

String formatToIDR(int amount) {
  final format = NumberFormat.simpleCurrency(locale: 'id_ID');
  return format.format(amount);
}

String formatDate(String date){
  DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
  String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
  return formattedDate;
}

List<CashFlow> sortRecent(List<CashFlow> cashFlow){
  cashFlow.sort((a, b) {
    return DateTime.parse(b.date).compareTo(DateTime.parse(a.date));
  });
  return cashFlow;
}