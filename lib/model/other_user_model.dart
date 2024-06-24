class OtherUserModel {
  final uid;
  final name;
  final freelancer;
  final city;
  final skills;
  final education;
  final experience;
  final aboutMe;
  final clientVisiting;
  final rating;
  final emailSuccess;
  const OtherUserModel({
    required this.uid,
    required this.freelancer,
    required this.name,
    required this.city,
    required this.rating,
    required this.experience,
    required this.aboutMe,
    required this.clientVisiting,
    required this.education,
    required this.emailSuccess,
    required this.skills,
});
  @override
  String toString() {
    // TODO: implement toString
    return "$uid, $name,  $freelancer, $city, $skills, $education, $experience, $aboutMe, $clientVisiting, $rating, $emailSuccess";
  }
}


//     'skills': data['skills'],
//     'education': data['education'],
//     'experience': data['experience'],
//     'about_me': data['about_me'],
//     'client_visiting': data['client_visiting'],
//     'rating': data['rating'],
//     'email_succes': data['email_succes'],