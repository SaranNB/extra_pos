class ValidationMessage {
  bool valid;
  String? message;

  get invalid => !this.valid;

  ValidationMessage({this.valid = false, this.message});

  void setError(String message) {
    this.message = message;
    this.valid = false;
  }

  void setValid() {
    this.message = null;
    this.valid = true;
  }
}