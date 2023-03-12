class RatingModel{
  String ratedBy;
  String apartmentUid;
  String comments;
  double rating;

  RatingModel({required this.apartmentUid, required this.comments, required this.rating, required this.ratedBy});

  Map<String, dynamic> toJson(){
    return {
      'ratedBy': ratedBy,
      'apartmentUid': apartmentUid,
      'comments': comments,
      'rating': rating,
    };
  }
}