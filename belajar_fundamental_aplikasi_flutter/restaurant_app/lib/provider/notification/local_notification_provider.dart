import 'package:flutter/widgets.dart';

import '../../services/local_notification_service.dart';
import '../../utils/conversion.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService){
    requestPermissions();
  }

  final int _notificationId = 1;
  final int hour = 11;
  final int minute = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void scheduleDailyNotification() {
    flutterNotificationService.scheduleDailyNotification(
      id: _notificationId,
      title: "Makan Yuk",
      body: "Jangan lupa makan, ini sudah jam ${Conversion.timeFormat(hour, minute)}",
      scheduleHour: hour,
      scheduleMinute: minute
    );
  }

  Future<void> cancelNotification() async {
    await flutterNotificationService.cancelNotification(_notificationId);
  }

  Future<void> toggleDailyReminder(bool enable) async {
    if (enable) {
      scheduleDailyNotification();
    } else {
      cancelNotification();
    }
    notifyListeners();
  }
}