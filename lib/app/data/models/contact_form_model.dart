class ContactFormModel {
  final String name;
  final String email;
  final String phone;
  final String interest; // which program / plan they're asking about
  final String message;

  const ContactFormModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.interest,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'interest': interest,
        'message': message,
      };
}
