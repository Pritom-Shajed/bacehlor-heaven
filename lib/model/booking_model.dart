class BookingModel {
  String checkIn;
  String checkOut;
  String persons;
  String bookedByUid;
  String apartmentUid;
  String title;
  String pictureUrl;
  String category;

  BookingModel({
    required this.checkIn,
    required this.checkOut,
    required this.persons,
    required this.bookedByUid,
    required this.apartmentUid,
    required this.title,
    required this.pictureUrl,
    required this.category,
  });

  Map<String, dynamic> toJson(){
    return {
      'checkIn': checkIn,
      'checkOut': checkOut,
      'persons': persons,
      'bookedByUid': bookedByUid,
      'apartmentUid': apartmentUid,
      'title': title,
      'category': category,
      'pictureUrl': pictureUrl,
    };
  }
}
