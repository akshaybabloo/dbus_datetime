import 'dart:io';

/// Offline lookup for country and IANA timezone mappings backed by the tzdata
/// files shipped with every Linux distribution.
///
/// systemd does not expose this information over D-Bus, so this class reads
/// `zone1970.tab` (or `zone.tab` as a fallback) and `iso3166.tab` from the
/// zoneinfo directory. Results are cached per instance after the first read.
class ZoneTab {
  ZoneTab({String zoneinfoDir = '/usr/share/zoneinfo'}) : _zoneinfoDir = zoneinfoDir;

  final String _zoneinfoDir;

  Map<String, String>? _countries;
  Map<String, List<String>>? _countryTimezones;

  /// ISO 3166-1 alpha-2 code to human-readable country name.
  Future<Map<String, String>> getCountries() async {
    if (_countries != null) return _countries!;

    final file = File('$_zoneinfoDir/iso3166.tab');
    if (!await file.exists()) {
      throw FileSystemException('tzdata not installed', file.path);
    }

    final result = <String, String>{};
    for (final line in await file.readAsLines()) {
      if (line.isEmpty || line.startsWith('#')) continue;
      final parts = line.split('\t');
      if (parts.length < 2) continue;
      final code = parts[0].trim().toUpperCase();
      final name = parts[1].trim();
      if (code.isEmpty || name.isEmpty) continue;
      result[code] = name;
    }

    return _countries = Map.unmodifiable(result);
  }

  /// ISO 3166-1 alpha-2 code to sorted list of IANA timezone names for that
  /// country. Prefers `zone1970.tab` (which supports multi-country zones) and
  /// falls back to `zone.tab`.
  Future<Map<String, List<String>>> getCountryTimezones() async {
    if (_countryTimezones != null) return _countryTimezones!;

    final zone1970 = File('$_zoneinfoDir/zone1970.tab');
    final zone = File('$_zoneinfoDir/zone.tab');

    final File source;
    if (await zone1970.exists()) {
      source = zone1970;
    } else if (await zone.exists()) {
      source = zone;
    } else {
      throw FileSystemException('tzdata not installed', zone1970.path);
    }

    final result = <String, List<String>>{};
    for (final line in await source.readAsLines()) {
      if (line.isEmpty || line.startsWith('#')) continue;
      final parts = line.split('\t');
      if (parts.length < 3) continue;
      final codes = parts[0].split(',');
      final tz = parts[2].trim();
      if (tz.isEmpty) continue;
      for (final raw in codes) {
        final code = raw.trim().toUpperCase();
        if (code.isEmpty) continue;
        (result[code] ??= <String>[]).add(tz);
      }
    }

    for (final list in result.values) {
      list.sort();
    }

    return _countryTimezones = Map<String, List<String>>.unmodifiable({
      for (final entry in result.entries) entry.key: List<String>.unmodifiable(entry.value),
    });
  }

  /// Timezones for a single country code (case-insensitive). Returns an empty
  /// list when the code is unknown.
  Future<List<String>> timezonesForCountry(String countryCode) async {
    final map = await getCountryTimezones();
    return map[countryCode.toUpperCase()] ?? const <String>[];
  }

  /// ISO codes whose timezone list contains [timezone]. Useful for
  /// pre-selecting a country from the current system timezone. Returns an
  /// empty list when the timezone is unknown.
  Future<List<String>> countriesForTimezone(String timezone) async {
    final map = await getCountryTimezones();
    final matches = <String>[];
    for (final entry in map.entries) {
      if (entry.value.contains(timezone)) matches.add(entry.key);
    }
    matches.sort();
    return matches;
  }
}
