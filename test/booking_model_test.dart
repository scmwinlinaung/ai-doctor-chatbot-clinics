import 'package:flutter_test/flutter_test.dart';
import 'package:clinics/features/booking/model/clinic_booking_model.dart';

void main() {
  group('ClinicBookingModel Tests', () {
    test('should parse city and region from json successfully', () {
      final json = {
        '_id': '1234567890',
        'clinic': 'clinic_abc',
        'patientName': 'John Doe',
        'age': 30,
        'city': 'Yangon',
        'region': 'Yangon Region',
        'status': 'booking',
      };

      final model = ClinicBookingModel.fromJson(json);

      expect(model.id, '1234567890');
      expect(model.clinic, 'clinic_abc');
      expect(model.patientName, 'John Doe');
      expect(model.age, 30);
      expect(model.city, 'Yangon');
      expect(model.region, 'Yangon Region');
      expect(model.status, BookingStatus.booking);
    });

    test('should handle missing city and region in json successfully', () {
      final json = {
        '_id': '1234567890',
        'clinic': 'clinic_abc',
        'patientName': 'John Doe',
        'age': 30,
        'status': 'booking',
      };

      final model = ClinicBookingModel.fromJson(json);

      expect(model.id, '1234567890');
      expect(model.city, isNull);
      expect(model.region, isNull);
    });
  });
}
