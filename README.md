# DBusDateTime

`DBusDateTime` is a Dart library for interacting with the system's date and time settings using D-Bus. It provides methods to retrieve and modify time-related settings, such as timezones, current time, and NTP synchronization.

## Features

- List all available timezones.
- Get the current timezone.
- Retrieve the current time in various formats (microseconds, ISO 8601, UTC).
- Check and enable NTP synchronization.
- Set the system timezone and time.
- Set NTP servers for synchronization.
- Offline country-to-timezone lookup via `ZoneTab`.

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

## Country and Timezone Lookup

systemd-timedated does not expose country metadata over D-Bus, so building a country picker on top of `getAvailableTimezones()` is awkward. The `ZoneTab` helper fills that gap by parsing the tzdata files shipped with every Linux distribution (`/usr/share/zoneinfo/zone1970.tab`, falling back to `zone.tab`, plus `iso3166.tab`).

```dart
import 'package:dbus_datetime/dbus_datetime.dart';

void main() async {
  final zoneTab = ZoneTab();

  // ISO 3166 alpha-2 code -> human-readable country name.
  final countries = await zoneTab.getCountries();
  print(countries['NZ']); // New Zealand

  // Timezones for a given country.
  final zones = await zoneTab.timezonesForCountry('NZ');
  print(zones); // [Pacific/Auckland, Pacific/Chatham]

  // Pre-select a country from the current system timezone.
  final codes = await zoneTab.countriesForTimezone('Europe/Zurich');
  print(codes); // [CH, DE, LI]
}
```

`ZoneTab` is backed by files, not D-Bus. It is purely offline and adds no runtime dependencies. Pass `zoneinfoDir:` to the constructor to point at a different directory (useful in tests).

## License

This project is licensed under the MIT License.
