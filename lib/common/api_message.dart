enum ApiMessage {
  unknown;

  static ApiMessage fromString(String value) {
    switch (value) {
      default:
        return ApiMessage.unknown;
    }
  }
}
