import 'package:dbus_datetime/dbus_datetime.dart';

void main(List<String> arguments) async {
  final dbusDateTime = DBusDateTime();
  final timezones = await dbusDateTime.getAvailableTimezones();
  print('Available Timezones:');
  for (var timezone in timezones) {
    print(timezone);
  }

  print("");

  final currentTimezone = await dbusDateTime.getCurrentTimezone();
  print('Current Timezone: $currentTimezone');

  print("");

  final currentTime = await dbusDateTime.getCurrentTime();
  final currentTimeISO = await dbusDateTime.getCurrentTimeISO();
  print('Current Time: $currentTime');
  print('Current Time ISO: $currentTimeISO');

  await dbusDateTime.close();
}
