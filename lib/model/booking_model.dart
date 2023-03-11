class BookingModel {
  String bookingStatus;
  String bookingUid;
  String cancelled;
  String adOwnerUid;
  String checkIn;
  String checkOut;
  String persons;
  String adBookedByUid;
  String apartmentUid;
  String title;
  String pictureUrl;
  String category;
  String price;
  String address;

  BookingModel({
    required this.bookingStatus,
    required this.bookingUid,
    required this.cancelled,
    required this.adOwnerUid,
    required this.checkIn,
    required this.checkOut,
    required this.persons,
    required this.adBookedByUid,
    required this.apartmentUid,
    required this.title,
    required this.pictureUrl,
    required this.category,
    required this.price,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookingStatus': bookingStatus,
      'bookingUid': bookingUid,
      'cancelled': cancelled,
      'adOwnerUid': adOwnerUid,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'persons': persons,
      'adBookedByUid': adBookedByUid,
      'apartmentUid': apartmentUid,
      'title': title,
      'category': category,
      'pictureUrl': pictureUrl,
      'price': price,
      'address': address,
    };
  }
}

class CancelBookingModel {
  String cancelled;

  CancelBookingModel({
    required this.cancelled,
  });

  Map<String, dynamic> toJson() {
    return {
      'cancelled': cancelled,
    };
  }
}
