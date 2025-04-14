# DBusDateTime Examples

This folder contains examples demonstrating how to use the DBusDateTime package.

## Basic Usage

```dart
import 'package:dbus_datetime/dbus_datetime.dart';

void main() async {
  final dbusDateTime = DBusDateTime();

  // List available timezones
  final timezones = await dbusDateTime.getAvailableTimezones();
  print('Available Timezones:');
  for (var timezone in timezones) {
    print(timezone);
  }

  // Get the current timezone
  final currentTimezone = await dbusDateTime.getCurrentTimezone();
  print('Current Timezone: $currentTimezone');

  // Get the current time in different formats
  final currentTime = await dbusDateTime.getCurrentTime();
  final currentTimeISO = await dbusDateTime.getCurrentTimeISO();
  final currentTimeUTC = await dbusDateTime.getCurrentTimeUTC();
  
  print('Current Time (microseconds since epoch): $currentTime');
  print('Current Time (ISO 8601): $currentTimeISO');
  print('Current Time (UTC): $currentTimeUTC');

  // Check if NTP is synchronized
  final isNtpSynchronized = await dbusDateTime.isNTP();
  print('Is NTP synchronized: $isNtpSynchronized');

  // Modify system settings (requires root privileges)
  try {
    // Set the timezone
    await dbusDateTime.setTimezone('America/New_York');
    print('Timezone set to America/New_York');

    // Set the system time
    final newTime = DateTime(2025, 4, 15, 12, 0, 0).microsecondsSinceEpoch;
    await dbusDateTime.setTime(newTime);
    print('System time set to 2025-04-15 12:00:00');

    // Enable NTP synchronization
    await dbusDateTime.synchronizeTime();
    print('NTP synchronization enabled');
  } catch (e) {
    print('Error modifying system settings: $e');
    print('Note: Modifying time settings typically requires root privileges');
  }

  // Always close the connection when done
  await dbusDateTime.close();
}
```
