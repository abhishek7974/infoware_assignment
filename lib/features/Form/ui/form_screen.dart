// form_page.dart
import 'package:assignment/features/Form/bloc/form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/form_bloc.dart';
import '../bloc/form_event.dart';


class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormFields(),
      ),
    );
  }
}

class FormFields extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormStateBl>(
      builder: (context, state) {
        return ListView(
          
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: countryController,
              decoration: InputDecoration(labelText: 'Country'),
            ),
            TextField(
              controller: stateController,
              decoration: InputDecoration(labelText: 'State'),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<FormBloc>().add(FormDataUpdated(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    gender: genderController.text,
                    country: countryController.text,
                    state: stateController.text,
                    city: cityController.text,
                  ));
                  context.read<FormBloc>().add(FormSubmitted());
                },
                child: Text('Submit'),
              ),
            ),
            if (state is FormInvalid) ...[
              Text('Error: ${state.error}', style: TextStyle(color: Colors.red)),
            ],
            if (state is FormSubmissionSuccess) ...[
              Text('Form submitted successfully!', style: TextStyle(color: Colors.green)),
            ],
          ],
        );
      },
    );
  }
}
