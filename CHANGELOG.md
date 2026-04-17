## 0.1.0

- Added `ZoneTab` for offline country and IANA timezone lookup backed by `/usr/share/zoneinfo/zone1970.tab` (with a `zone.tab` fallback) and `iso3166.tab`. systemd-timedated does not expose country metadata over D-Bus, so this fills the gap for country-picker UIs.

## 0.0.4

- Fix example code in example/README.md.

## 0.0.3

- Added two methods to enable and disable NTP synchronisation.
- Optional `relative` property added to `set_time` and by default set to `false`.

## 0.0.2

- Added support for setting NTP servers.

## 0.0.1

- Initial version.
