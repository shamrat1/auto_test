class ValidationErrorResponse {
  final String? message;
  final Map<String, List<String>>? errors;

  ValidationErrorResponse({
    this.message,
    this.errors,
  });

  // Factory constructor to parse JSON into the ValidationErrorResponse model
  factory ValidationErrorResponse.fromJson(Map<String, dynamic> json) {
    return ValidationErrorResponse(
      message: json['message'] ?? '',
      errors: (json['errors'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, List<String>.from(value)),
      ),
    );
  }

  // Returns all error messages as a single list
  List<String>? getAllErrors() {
    return errors?.values.expand((errorList) => errorList).toList();
  }

  // Gets errors for a specific field, e.g., 'car_make'
  List<String>? getErrorsForField(String field) {
    return errors?[field] ?? [];
  }
}
