// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object ./interfaces/org.freedesktop.timedate1.xml

import 'dart:io';
import 'package:dbus/dbus.dart';

class OrgFreedesktopTimedate1 extends DBusRemoteObject {
  OrgFreedesktopTimedate1(DBusClient client, String destination, {DBusObjectPath path = const DBusObjectPath.unchecked('/org/freedesktop/timedate1')}) : super(client, name: destination, path: path);

  /// Gets org.freedesktop.timedate1.Timezone
  Future<String> getTimezone() async {
    var value = await getProperty('org.freedesktop.timedate1', 'Timezone', signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.timedate1.LocalRTC
  Future<bool> getLocalRTC() async {
    var value = await getProperty('org.freedesktop.timedate1', 'LocalRTC', signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.freedesktop.timedate1.CanNTP
  Future<bool> getCanNTP() async {
    var value = await getProperty('org.freedesktop.timedate1', 'CanNTP', signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.freedesktop.timedate1.NTP
  Future<bool> getNTP() async {
    var value = await getProperty('org.freedesktop.timedate1', 'NTP', signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.freedesktop.timedate1.NTPSynchronized
  Future<bool> getNTPSynchronized() async {
    var value = await getProperty('org.freedesktop.timedate1', 'NTPSynchronized', signature: DBusSignature('b'));
    return value.asBoolean();
  }

  /// Gets org.freedesktop.timedate1.TimeUSec
  Future<int> getTimeUSec() async {
    var value = await getProperty('org.freedesktop.timedate1', 'TimeUSec', signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.timedate1.RTCTimeUSec
  Future<int> getRTCTimeUSec() async {
    var value = await getProperty('org.freedesktop.timedate1', 'RTCTimeUSec', signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Invokes org.freedesktop.timedate1.SetTime()
  Future<void> callSetTime(int usec_utc, bool relative, bool interactive, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.timedate1', 'SetTime', [DBusInt64(usec_utc), DBusBoolean(relative), DBusBoolean(interactive)], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.timedate1.SetTimezone()
  Future<void> callSetTimezone(String timezone, bool interactive, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.timedate1', 'SetTimezone', [DBusString(timezone), DBusBoolean(interactive)], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.timedate1.SetLocalRTC()
  Future<void> callSetLocalRTC(bool local_rtc, bool fix_system, bool interactive, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.timedate1', 'SetLocalRTC', [DBusBoolean(local_rtc), DBusBoolean(fix_system), DBusBoolean(interactive)], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.timedate1.SetNTP()
  Future<void> callSetNTP(bool use_ntp, bool interactive, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.timedate1', 'SetNTP', [DBusBoolean(use_ntp), DBusBoolean(interactive)], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }

  /// Invokes org.freedesktop.timedate1.ListTimezones()
  Future<List<String>> callListTimezones({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.timedate1', 'ListTimezones', [], replySignature: DBusSignature('as'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asStringArray().toList();
  }
}
