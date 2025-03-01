import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../services/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService){
    requestPermissions();
  }

  final int _notificationId = 1;
  bool? _permission = false;
  bool? get permission => _permission;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void scheduleDailyNotification() {
    final hour = 18;
    final minute = 00;
    flutterNotificationService.scheduleDailyNotification(
      id: _notificationId,
      title: "Makan Yuk",
      body: "Jangan lupa makan, ini sudah jam $hour:$minute siang",
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

  Future<String> checkPendingNotificationRequests() async {
    pendingNotificationRequests = await flutterNotificationService.pendingNotificationRequests();
    notifyListeners();
    var temp ="";
    for (var notification in pendingNotificationRequests) {
      temp = "📌 ID: ${notification.id}, Title: ${notification.title}, Body: ${notification.body}";
      // print("📌 ID: ${notification.id}, Title: ${notification.title}, Body: ${notification.body}");
    }
    return temp;
  }

  // void showNotification() {
  //   _notificationId += 1;
  //   flutterNotificationService.showNotification(
  //     id: _notificationId,
  //     title: "New Notification",
  //     body: "This is a new notification with id $_notificationId",
  //     payload: "This is a payload from notification with id $_notificationId",
  //   );
  // }
}