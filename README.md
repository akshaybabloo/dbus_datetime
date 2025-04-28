# DBusDateTime

`DBusDateTime` is a Dart library for interacting with the system's date and time settings using D-Bus. It provides methods to retrieve and modify time-related settings, such as timezones, current time, and NTP synchronization.

## Features

- List all available timezones.
- Get the current timezone.
- Retrieve the current time in various formats (microseconds, ISO 8601, UTC).
- Check and enable NTP synchronization.
- Set the system timezone and time.
- Set NTP servers for synchronization.

## Installation

Add the package to your project using the following command:

```bash
dart pub add dbus_datetime
```

## Usage

Here is an example of how to use the `DBusDateTime` class:

```dart
import 'package:dbus_datetime/dbus_datetime.dart';

void main() async {
  final dbusDateTime = DBusDateTime();

  // List available timezones
  final timezones = await dbusDateTime.getAvailableTimezones();
  print('Available timezones: $timezones');

  // Get the current timezone
  final currentTimezone = await dbusDateTime.getCurrentTimezone();
  print('Current timezone: $currentTimezone');

  // Get the current time in ISO 8601 format
  final currentTimeISO = await dbusDateTime.getCurrentTimeISO();
  print('Current time (ISO 8601): $currentTimeISO');

  // Check if NTP is synchronized
  final isNtpSynchronized = await dbusDateTime.isNTP();
  print('Is NTP synchronized: $isNtpSynchronized');

  // Set the system timezone
  await dbusDateTime.setTimezone('Pacific/Auckland');
  print('Timezone set to Pacific/Auckland');

  // Set the system time (in microseconds since epoch)
  final newTime = DateTime(2025, 4, 15, 12, 0, 0).microsecondsSinceEpoch;
  await dbusDateTime.setTime(newTime);
  print('System time set to 2025-04-15 12:00:00');

  // Close the D-Bus client connection
  await dbusDateTime.close();
}
```

## License

This project is licensed under the MIT License.
