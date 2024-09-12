class Job {
  final int id;
  final String profile;
  final String location;
  final String codeRequired;
  final int code;
  final String companyName;
  final String education;
  final String skillsRequired;
  final String? knowledgeStars;
  final String whoCanApply;
  final String description;
  final String termsAndConditions;
  final double ctc;

  Job({
    required this.id,
    required this.profile,
    required this.location,
    required this.codeRequired,
    required this.code,
    required this.companyName,
    required this.education,
    required this.skillsRequired,
    this.knowledgeStars,
    required this.whoCanApply,
    required this.description,
    required this.termsAndConditions,
    required this.ctc,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      profile: json['profile'],
      location: json['location'],
      codeRequired: json['code_required'],
      code: json['code'],
      companyName: json['company_name'],
      education: json['education'],
      skillsRequired: json['skills_required'],
      knowledgeStars: json['knowledge_stars'],
      whoCanApply: json['who_can_apply'],
      description: json['description'],
      termsAndConditions: json['terms_and_conditions'],
      ctc: double.parse(json['CTC']),
    );
  }
}
