class BookingModel {
  String bookingStatus;
  String adOwnerUid;
  String checkIn;
  String checkOut;
  String persons;
  String adBookedByUid;
  String apartmentUid;
  String title;
  String pictureUrl;
  String category;

  BookingModel({
    required this.bookingStatus,
    required this.adOwnerUid,
    required this.checkIn,
    required this.checkOut,
    required this.persons,
    required this.adBookedByUid,
    required this.apartmentUid,
    required this.title,
    required this.pictureUrl,
    required this.category,
  });

  Map<String, dynamic> toJson(){
    return {
      'bookingStatus': bookingStatus,
      'adOwnerUid': adOwnerUid,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'persons': persons,
      'adBookedByUid': adBookedByUid,
      'apartmentUid': apartmentUid,
      'title': title,
      'category': category,
      'pictureUrl': pictureUrl,
    };
  }
}
