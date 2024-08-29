// form_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_event.dart';
import 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormStateBl> {
  String name = '';
  String email = '';
  String phone = '';
  String gender = '';
  String country = '';
  String stateVal = '';
  String city = '';

  FormBloc() : super(FormInitial()) {
    on<FormDataUpdated>((event, emit) {
      // Update internal form data
      name = event.name;
      email = event.email;
      phone = event.phone;
      gender = event.gender;
      country = event.country;
      stateVal = event.state;
      city = event.city;
    });

    on<FormSubmitted>((event, emit) async {
      final errors = _validateForm(
        name,
        email,
        phone,
        gender,
        country,
        stateVal,
        city,
      );

      if (errors.isEmpty) {
        // Simulate form submission
        emit(FormSubmissionSuccess());
      } else {
        emit(FormInvalid(errors));
      }
    });
  }

  String _validateForm(
      String name,
      String email,
      String phone,
      String gender,
      String country,
      String state,
      String city,
      ) {
    if (name.isEmpty) return 'Name is required';
    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) return 'Invalid email address';
    if (phone.isEmpty || !RegExp(r'^\d+$').hasMatch(phone)) return 'Invalid phone number';
    if (gender.isEmpty) return 'Gender is required';
    if (country.isEmpty) return 'Country is required';
    if (state.isEmpty) return 'State is required';
    if (city.isEmpty) return 'City is required';
    return '';
  }
}
