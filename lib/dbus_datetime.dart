import 'package:dbus/dbus.dart';
import 'package:dbus_datetime/interfaces/timedate1_remote_object.dart';

/// A class to interact with the system's date and time settings using D-Bus.
class DBusDateTime {
  final DBusClient _client;

  DBusDateTime() : _client = DBusClient.system();

  /// List all available timezones
  Future<List<String>> getAvailableTimezones() async {
    final nm = OrgFreedesktopTimedate1(_client, 'org.freedesktop.timedate1');
    final timeZones = await nm.callListTimezones();
    return timeZones;
  }

  /// Get the current timezone
  Future<String> getCurrentTimezone() async {
    final nm = OrgFreedesktopTimedate1(_client, 'org.freedesktop.timedate1');
    final timezone = await nm.getTimezone();
    return timezone;
  }

  /// Get the current time
  Future<int> getCurrentTime() async {
    final nm = OrgFreedesktopTimedate1(_client, 'org.freedesktop.timedate1');
    return nm.getTimeUSec();
  }

  /// Get the current time in ISO 8601 format
  Future<String> getCurrentTimeISO() async {
    final currentTime = await getCurrentTime();
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(currentTime);
    return dateTime.toIso8601String();
  }

  /// Get the current time UTC
  Future<String> getCurrentTimeUTC() async {
    final nm = OrgFreedesktopTimedate1(_client, 'org.freedesktop.timedate1');
    final currentTime = await nm.getRTCTimeUSec();
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(
      currentTime,
      isUtc: true,
    );
    return dateTime.toIso8601String();
  }

  /// Check if NTP is synchronized
  Future<bool> isNTP() async {
    final nm = OrgFreedesktopTimedate1(_client, 'org.freedesktop.timedate1');
    return nm.getNTP();
  }

  /// Synchronize the time with NTP
  Future<void> synchronizeTime() async {
    final nm = OrgFreedesktopTimedate1(_client, 'org.freedesktop.timedate1');
    await nm.callSetNTP(true, false);
  }

  /// Set the timezone
  Future<void> setTimezone(String timezone) async {
    final nm = OrgFreedesktopTimedate1(_client, 'org.freedesktop.timedate1');
    await nm.callSetTimezone(timezone, false);
  }

  /// Set the time
  Future<void> setTime(int time) async {
    final nm = OrgFreedesktopTimedate1(_client, 'org.freedesktop.timedate1');
    await nm.callSetTime(time, true, false);
  }

  /// Closes the D-Bus client connection
  Future<void> close() async {
    await _client.close();
  }
}
