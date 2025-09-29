enum AuthMessage {
  userCreated,
  userExists,
  unknown;

  static AuthMessage fromString(String value) {
    switch (value) {
      case 'User has been created successfully':
        return AuthMessage.userCreated;
      case 'User already exists':
        return AuthMessage.userExists;
      default:
        return AuthMessage.unknown;
    }
  }
}
