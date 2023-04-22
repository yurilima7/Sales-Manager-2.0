import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/core/ui/base_state/base_state.dart';
import 'package:sales_manager/app/core/ui/styles/button_app.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/input.dart';
import 'package:sales_manager/app/pages/auth/register/register_controller.dart';
import 'package:sales_manager/app/pages/auth/register/register_state.dart';
import 'package:validatorless/validatorless.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends BaseState<Register, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _passwordConfirmEC = TextEditingController();
  final _userNameEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _passwordConfirmEC.dispose();
    _userNameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          error: () {
            hideLoader();
            showErro('Erro ao registrar usuário');
          },
          success: () {
            hideLoader();
            showSuccess('Cadastro realizado com sucesso');
            Navigator.pop(context, true);
          },
        );
      },

      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    
          child: Scaffold(
            backgroundColor: context.colors.tertiary,
        
            appBar: AppBar(
              backgroundColor: context.colors.tertiary,
    
              title: Text(
                'Cadastre-se',
                style: context.textApp.appBarHome
                  .copyWith(
                    color: context.colors.secundary,
                    fontFamily: 'BebasNeue',
                  ),
              ),
    
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                iconSize: 20,
                color: context.colors.primary,
              ),
            ),
        
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
          
                child: LayoutBuilder(
                  builder: (_, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
          
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            const SizedBox(
                                height: 20,
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
          
                              children: [
                                Image.asset('assets/images/Logo-2.png', height: 160,),
                              ],
                            ),
          
                            const SizedBox(
                                height: 30,
                            ),
          
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Input(
                                    label: 'Nome de usuário',
                                    hintText: 'Digite seu nome de usuário',
                                    fillColor: true,
                                    controller: _userNameEC,
                                    validator: Validatorless.required(
                                      'Nome de usuário obrigatório'),
                                  ),
          
                                  const SizedBox(
                                    height: 20,
                                  ),
        
                                  Input(
                                    label: 'E-Mail',
                                    hintText: 'Digite seu e-mail',
                                    fillColor: true,
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
                                    fillColor: true,
                                    controller: _passwordEC,
                                    validator: Validatorless.multiple([
                                      Validatorless.required('Senha obrigatória'),
                                      Validatorless.min(
                                        8,
                                        'Senha deve conter pelo menos 8 caracteres',
                                      ),
                                    ]),
                                  ),
          
                                  const SizedBox(
                                      height: 20,
                                  ),
          
                                  Input(
                                    label: 'Confirma Senha',
                                    hintText: 'Confirme sua senha',
                                    isPassword: true,
                                    obscureText: true,
                                    fillColor: true,
                                    controller: _passwordConfirmEC,
                                    validator: Validatorless.multiple([
                                    Validatorless.required('Confirma senha obrigatória'),
                                    Validatorless.compare(
                                        _passwordEC,
                                        'Senha diferente de confirmação',
                                      ),
                                    ]),
                                  ),
          
                                  const SizedBox(
                                      height: 20,
                                  ),
          
                                  ElevatedButton(
                                    onPressed: () {
                                      final valid =
                                        _formKey.currentState?.validate() ??
                                            false;
                                      
                                      if (valid) {
                                        controller.register(
                                          _userNameEC.text,
                                          _emailEC.text,
                                          _passwordEC.text,
                                        );
                                      }
                                    },
                                    style: context.buttonApp.buttonLight,
                                    child: Text(
                                      'Registrar',
                                      style: context.textApp.textPrimaryLight,
                                    ),
                                  ),
          
                                  const SizedBox(
                                    height: 10,
                                  ),
          
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: Text(
                                      'Já possui uma conta? Faça seu login!',
                                      style: context.textApp.littleTextPrimary
                                          .copyWith(color: context.colors.secundary),
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
