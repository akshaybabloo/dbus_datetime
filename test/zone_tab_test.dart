import 'dart:io';

import 'package:dbus_datetime/zone_tab.dart';
import 'package:test/test.dart';

void main() {
  group('ZoneTab with zone1970.tab', () {
    late ZoneTab zoneTab;

    setUp(() {
      zoneTab = ZoneTab(zoneinfoDir: 'test/fixtures/zoneinfo');
    });

    test('getCountries returns ISO code → name map', () async {
      final countries = await zoneTab.getCountries();
      expect(countries['NZ'], 'New Zealand');
      expect(countries['US'], 'United States');
      expect(countries['CH'], 'Switzerland');
      expect(countries, hasLength(5));
    });

    test('getCountryTimezones maps single-zone country', () async {
      final map = await zoneTab.getCountryTimezones();
      expect(map['NZ'], ['Pacific/Auckland', 'Pacific/Chatham']);
    });

    test('getCountryTimezones returns sorted multi-zone list', () async {
      final map = await zoneTab.getCountryTimezones();
      expect(map['US'], [
        'America/Los_Angeles',
        'America/New_York',
        'America/Phoenix',
      ]);
    });

    test('multi-country zone row appears under every listed code', () async {
      final map = await zoneTab.getCountryTimezones();
      expect(map['CH'], contains('Europe/Zurich'));
      expect(map['DE'], contains('Europe/Zurich'));
      expect(map['LI'], contains('Europe/Zurich'));
    });

    test('timezonesForCountry is case-insensitive', () async {
      expect(await zoneTab.timezonesForCountry('nz'), [
        'Pacific/Auckland',
        'Pacific/Chatham',
      ]);
    });

    test('timezonesForCountry returns empty list for unknown code', () async {
      expect(await zoneTab.timezonesForCountry('ZZ'), isEmpty);
    });

    test('countriesForTimezone resolves shared zones', () async {
      expect(await zoneTab.countriesForTimezone('Europe/Zurich'), [
        'CH',
        'DE',
        'LI',
      ]);
    });

    test('countriesForTimezone returns empty list for unknown zone', () async {
      expect(await zoneTab.countriesForTimezone('Mars/Olympus_Mons'), isEmpty);
    });
  });

  group('ZoneTab fallback to zone.tab', () {
    test('reads zone.tab when zone1970.tab is missing', () async {
      final zoneTab = ZoneTab(zoneinfoDir: 'test/fixtures/zoneinfo_legacy');
      final map = await zoneTab.getCountryTimezones();
      expect(map['NZ'], ['Pacific/Auckland']);
      expect(map['US'], ['America/New_York']);
    });
  });

  group('ZoneTab error handling', () {
    test('throws FileSystemException when directory is missing', () async {
      final zoneTab = ZoneTab(zoneinfoDir: 'test/fixtures/does_not_exist');
      expect(
        () => zoneTab.getCountryTimezones(),
        throwsA(isA<FileSystemException>()),
      );
      expect(() => zoneTab.getCountries(), throwsA(isA<FileSystemException>()));
    });
  });
}
