class User {}

enum UserType {
  freelancer("Freelancer"),
  client("Cliente");

  final String text;
  const UserType(this.text);
}
