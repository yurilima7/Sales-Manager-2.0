import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/core/ui/base_state/base_state.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/google_button.dart';
import 'package:sales_manager/app/core/ui/widgets/input.dart';
import 'package:sales_manager/app/core/ui/widgets/sales_manager_button.dart';
import 'package:sales_manager/app/pages/auth/login/login_controller.dart';
import 'package:sales_manager/app/pages/auth/login/login_state.dart';
import 'package:validatorless/validatorless.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends BaseState<Login, LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          login: () => showLoader(),
          loginError: () {
            hideLoader();
            showErro('E-Mail ou senha inválidos');
          },
          error: () {
            hideLoader();
            showErro('Erro ao realizar login');
          },
          success: () {
            hideLoader();
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (Route<dynamic> route) => false,
            );
          },
        );
      },

      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
        
                child: LayoutBuilder(
                  builder: (_, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
        
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
        
                              children: [
                                Image.asset('assets/images/Logo.png', height: 160,),
                              ],
                            ),
        
                            const SizedBox(
                               height: 30,
                            ),
        
                            Text(
                              'Seja Bem-Vindo!',
                              style: context.textApp.primaryRegular
                                  .copyWith(
                                fontSize: 18,
                                color: context.colors.tertiary,
                              ),
                            ),
        
                            const SizedBox(
                               height: 30,
                            ),
        
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Input(
                                    label: 'E-Mail',
                                    hintText: 'Digite seu e-mail',
                                    controller: _emailEC,
                                    validator: Validatorless.multiple([
                                      Validatorless.required('E-Mail obrigatório'),
                                      Validatorless.email('E-Mail inválido'),
                                    ]),
                                  ),
        
                                  const SizedBox(
                                    height: 20,
                                  ),
        
                                  Input(
                                    label: 'Senha',
                                    hintText: 'Digite sua senha',
                                    isPassword: true,
                                    obscureText: true,
                                    controller: _passwordEC,
                                    validator: Validatorless.multiple([
                                      Validatorless.required('Senha obrigatória'),
                                    ]),
                                  ),
        
                                  const SizedBox(
                                     height: 20,
                                  ),
        
                                  SalesManagerButton(
                                    label: 'Entrar',
                                    onPressed: () {
                                      final valid =
                                        _formKey.currentState?.validate() ??
                                            false;

                                      if (valid) {
                                        controller.login(
                                          _emailEC.text,
                                          _passwordEC.text,
                                        );
                                      }
                                    },
                                  ),
        
                                  const SizedBox(
                                    height: 20,
                                  ),
        
                                  const GoogleButton(),
        
                                  const SizedBox(
                                    height: 10,
                                  ),
        
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    
                                    child: TextButton(
                                      onPressed: () => Navigator.of(context)
                                          .pushNamed('/auth/register'),
                                          
                                      child: Text(
                                        'Não possui uma conta? Crie já a sua!',
                                        style: context.textApp.littleTextPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
