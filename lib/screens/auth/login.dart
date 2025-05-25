import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/extensions/theme_extension.dart';
import 'package:syncman_new/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/providers/database_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _rememberMe = false;
  final _usernameController = TextEditingController(text: 'cpagua');
  final _passwordController = TextEditingController(text: '1234');

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Attempt to log in
      try {
        final response = await ApiService().postRequest(
          '/vendedores/login',
          data: {
            'login': _usernameController.text.trim(),
            'password': _passwordController.text.trim(),
          },
        );

        if (mounted) Navigator.pop(context); // Dismiss the loading indicator

        if (response != null && response.statusCode == 200 && mounted) {
          final responseData = response.data;

          // Verify if the response contains a token and save it
          if (responseData != null && responseData['token'] != null) {
            final String token = responseData['token'];
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('authToken', token);
          }

          if (mounted) Navigator.pushReplacementNamed(context, Routes.collect);
        } else {
          // Show error message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Usuario o contraseña incorrectos')),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          Navigator.pop(context); // Dismiss the loading indicator
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al iniciar sesión')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 220,
                    height: 176,
                  ),
                ),

                const SizedBox(height: 30.0),

                const Text('Inicio de sesión',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),

                const SizedBox(height: 40),

                // Login Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Username Field
                      TextFormField(
                        style: context.textTheme.bodyMedium,
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Usuario',
                          labelStyle: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                          hintStyle: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor, ingrese su usuario';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Password Field
                      TextFormField(
                        style: context.textTheme.bodyMedium,
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelStyle: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                          hintStyle: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                          labelText: 'Contraseña',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor, ingrese su contraseña';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Remember Me Checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                          ),
                          Text('Recordar',
                              style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins')),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                          ),
                          child: Text(
                            'Iniciar sesión',
                            style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Regenerate DB Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await context.read<DatabaseProvider>().regenerateDB();
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Base de datos regenerada exitosamente'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error al regenerar la base de datos: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            backgroundColor: Colors.orange,
                          ),
                          child: Text(
                            'Regenerar Base de Datos',
                            style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Desarrollado por',
                        style: context.textTheme.bodySmall
                            ?.copyWith(fontFamily: 'Poppins')),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset('assets/images/secondary-logo.png',
                          width: 122, height: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
