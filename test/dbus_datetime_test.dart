import 'package:dbus_datetime/dbus_datetime.dart';
import 'package:test/test.dart';

void main() {
  test('DBusSecrets can be instantiated', () {
    // This test just verifies that the DBusDateTime class can be instantiated
    // without errors.
    expect(() => DBusDateTime(), returnsNormally);
  });
}
