import 'package:dbus/dbus.dart';
import 'package:dbus_datetime/interfaces/timedate1_remote_object.dart';

import 'interfaces/timesync1_remote_object.dart';

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

  /// Enable NTP synchronization
  Future<void> enableNTP() async {
    final nm = OrgFreedesktopTimedate1(_client, 'org.freedesktop.timedate1');
    await nm.callSetNTP(true, false);
  }

  /// Disable NTP synchronization
  Future<void> disableNTP() async {
    final nm = OrgFreedesktopTimedate1(_client, 'org.freedesktop.timedate1');
    await nm.callSetNTP(false, false);
  }

  /// Set the timezone
  Future<void> setTimezone(String timezone) async {
    final nm = OrgFreedesktopTimedate1(_client, 'org.freedesktop.timedate1');
    await nm.callSetTimezone(timezone, false);
  }

  /// Set the time
  ///
  /// Setting `relative` to `true` will set the time relative to the current time,
  /// as it adds the provided time to the current time. When `false`, it sets the time to the provided value.
  Future<void> setTime(int time, {bool relative = false}) async {
    final nm = OrgFreedesktopTimedate1(_client, 'org.freedesktop.timedate1');
    await nm.callSetTime(time, relative, false);
  }

  /// Set NTP server addresses
  Future<void> setNTPServers(List<String> url) async {
    final nm = OrgFreedesktopTimesync1(_client, 'org.freedesktop.timesync1');
    await nm.callSetRuntimeNTPServers(url);
  }

  /// Closes the D-Bus client connection
  Future<void> close() async {
    await _client.close();
  }
}
