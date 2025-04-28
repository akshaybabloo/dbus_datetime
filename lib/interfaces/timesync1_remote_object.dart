// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object ./interfaces/org.freedesktop.timesync1.xml

import 'dart:io';
import 'package:dbus/dbus.dart';

class OrgFreedesktopTimesync1 extends DBusRemoteObject {
  OrgFreedesktopTimesync1(DBusClient client, String destination, {DBusObjectPath path = const DBusObjectPath.unchecked('/org/freedesktop/timesync1')}) : super(client, name: destination, path: path);

  /// Gets org.freedesktop.timesync1.Manager.LinkNTPServers
  Future<List<String>> getLinkNTPServers() async {
    var value = await getProperty('org.freedesktop.timesync1.Manager', 'LinkNTPServers', signature: DBusSignature('as'));
    return value.asStringArray().toList();
  }

  /// Gets org.freedesktop.timesync1.Manager.SystemNTPServers
  Future<List<String>> getSystemNTPServers() async {
    var value = await getProperty('org.freedesktop.timesync1.Manager', 'SystemNTPServers', signature: DBusSignature('as'));
    return value.asStringArray().toList();
  }

  /// Gets org.freedesktop.timesync1.Manager.RuntimeNTPServers
  Future<List<String>> getRuntimeNTPServers() async {
    var value = await getProperty('org.freedesktop.timesync1.Manager', 'RuntimeNTPServers', signature: DBusSignature('as'));
    return value.asStringArray().toList();
  }

  /// Gets org.freedesktop.timesync1.Manager.FallbackNTPServers
  Future<List<String>> getFallbackNTPServers() async {
    var value = await getProperty('org.freedesktop.timesync1.Manager', 'FallbackNTPServers', signature: DBusSignature('as'));
    return value.asStringArray().toList();
  }

  /// Gets org.freedesktop.timesync1.Manager.ServerName
  Future<String> getServerName() async {
    var value = await getProperty('org.freedesktop.timesync1.Manager', 'ServerName', signature: DBusSignature('s'));
    return value.asString();
  }

  /// Gets org.freedesktop.timesync1.Manager.ServerAddress
  Future<List<DBusValue>> getServerAddress() async {
    var value = await getProperty('org.freedesktop.timesync1.Manager', 'ServerAddress', signature: DBusSignature('(iay)'));
    return value.asStruct();
  }

  /// Gets org.freedesktop.timesync1.Manager.RootDistanceMaxUSec
  Future<int> getRootDistanceMaxUSec() async {
    var value = await getProperty('org.freedesktop.timesync1.Manager', 'RootDistanceMaxUSec', signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.timesync1.Manager.PollIntervalMinUSec
  Future<int> getPollIntervalMinUSec() async {
    var value = await getProperty('org.freedesktop.timesync1.Manager', 'PollIntervalMinUSec', signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.timesync1.Manager.PollIntervalMaxUSec
  Future<int> getPollIntervalMaxUSec() async {
    var value = await getProperty('org.freedesktop.timesync1.Manager', 'PollIntervalMaxUSec', signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.timesync1.Manager.PollIntervalUSec
  Future<int> getPollIntervalUSec() async {
    var value = await getProperty('org.freedesktop.timesync1.Manager', 'PollIntervalUSec', signature: DBusSignature('t'));
    return value.asUint64();
  }

  /// Gets org.freedesktop.timesync1.Manager.NTPMessage
  Future<List<DBusValue>> getNTPMessage() async {
    var value = await getProperty('org.freedesktop.timesync1.Manager', 'NTPMessage', signature: DBusSignature('(uuuuittayttttbtt)'));
    return value.asStruct();
  }

  /// Gets org.freedesktop.timesync1.Manager.Frequency
  Future<int> getFrequency() async {
    var value = await getProperty('org.freedesktop.timesync1.Manager', 'Frequency', signature: DBusSignature('x'));
    return value.asInt64();
  }

  /// Invokes org.freedesktop.timesync1.Manager.SetRuntimeNTPServers()
  Future<void> callSetRuntimeNTPServers(List<String> runtime_servers, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    await callMethod('org.freedesktop.timesync1.Manager', 'SetRuntimeNTPServers', [DBusArray.string(runtime_servers)], replySignature: DBusSignature(''), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
  }
}
