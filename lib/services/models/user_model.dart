class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final Map? address;
  final String? phone;
  final String? website;
  final Map? company;

  const UserModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      this.address,
      this.phone,
      this.website,
      this.company});
}
