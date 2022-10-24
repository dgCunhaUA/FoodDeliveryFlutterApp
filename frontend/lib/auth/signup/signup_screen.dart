import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/auth/signup/signup_bloc.dart';

import '../../repositories/user_repository.dart';
import '../../services/client_api.dart';
import '../../services/storage.dart';
import '../../utils/validator.dart';
import '../../widgets/tabbar_menu.dart';
import '../auth_cubit.dart';
import '../form_submission_status.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenScreenState();
}

class _SignUpScreenScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  final Storage storage = Storage();
  bool _showPassword = false;

  bool rider = false;
  static const List<String> vehicles = <String>['Carro', 'Mota', 'Bicicleta'];
  String vehicleSelected = vehicles.first;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SignUpBloc(
        userRepo: context.read<UserRepository>(),
        authCubit: context.read<AuthCubit>(),
      ),
      child: Scaffold(
        backgroundColor: Colors.green[100],
        body: _signUpForm(size),
      ),
    );
  }

  Widget _signUpForm(size) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Stack(children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: size.width * 0.85,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // SizedBox(height: size.height * 0.08),
                        const Center(
                          child: Text(
                            "Registar",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Switch(
                            // This bool value toggles the switch.
                            value: rider,
                            activeColor: Colors.orange,
                            onChanged: (bool value) {
                              // This is called when the user toggles the switch.
                              setState(() {
                                rider = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        _signUpInputs(size),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                                onPressed: () =>
                                    context.read<AuthCubit>().showLogin(),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15)),
                                child: const Text("Login")),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _signUpInputs(size) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(children: [
          TextFormField(
            controller: firstNameController,
            validator: (value) {
              return Validator.validateName(value ?? "");
            },
            onChanged: (value) => context.read<SignUpBloc>().add(
                  SignUpUsernameChanged(username: value),
                ),
            decoration: InputDecoration(
              hintText: "Name",
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          TextFormField(
            controller: emailController,
            validator: (value) {
              return Validator.validateEmail(value ?? "");
            },
            onChanged: (value) => context.read<SignUpBloc>().add(
                  SignUpEmailChanged(email: value),
                ),
            decoration: InputDecoration(
              hintText: "Email",
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          TextFormField(
            obscureText: !_showPassword,
            controller: passwordController,
            validator: (value) {
              return Validator.validatePassword(value ?? "");
            },
            onChanged: (value) => context.read<SignUpBloc>().add(
                  SignUpPasswordChanged(password: value),
                ),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() => _showPassword = !_showPassword);
                },
                child: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
              hintText: "Password",
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          TextFormField(
            controller: addressController,
            validator: (value) {
              return Validator.validateText(value ?? "");
            },
            onChanged: (value) => context.read<SignUpBloc>().add(
                  SignUpAddressChanged(address: value),
                ),
            decoration: InputDecoration(
              hintText: "Address",
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          if (rider)
            DropdownButton<String>(
              value: vehicleSelected,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.orange,
              ),
              /* onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  vehicleSelected = value!;
                });
              }, */
              onChanged: (value) => {
                setState(() {
                  vehicleSelected = value!;
                }),
                context.read<SignUpBloc>().add(
                      SignUpVehicleChanged(vehicle: value!),
                    ),
              },
              items: vehicles.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          if (rider) SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SignUpBloc>().add(SignUpSubmitted());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: rider ? Colors.orange : Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15)),
                  child: const Text(
                    "Registar",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ]);
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[600],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
