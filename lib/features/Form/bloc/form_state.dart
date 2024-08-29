// form_state.dart
abstract class FormStateBl {}

class FormInitial extends FormStateBl {}

class FormValid extends FormStateBl {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String country;
  final String state;
  final String city;

  FormValid({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.country,
    required this.state,
    required this.city,
  });
}

class FormInvalid extends FormStateBl {
  final String error;

  FormInvalid(this.error);
}

class FormSubmissionSuccess extends FormStateBl {}

class FormSubmissionFailure extends FormStateBl {
  final String error;

  FormSubmissionFailure(this.error);
}
