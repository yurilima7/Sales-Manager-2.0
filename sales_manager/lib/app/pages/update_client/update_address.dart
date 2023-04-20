import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/core/ui/base_state/base_state.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/input.dart';
import 'package:sales_manager/app/core/ui/widgets/sales_manager_button.dart';
import 'package:sales_manager/app/pages/update_client/update_client_controller.dart';
import 'package:sales_manager/app/pages/update_client/update_client_state.dart';
import 'package:validatorless/validatorless.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({super.key});

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends BaseState<UpdateAddress, UpdateClientController> {
  final _formKey = GlobalKey<FormState>();
  final formData = <String, Object>{};
  List<String>? client;

   @override
  void didChangeDependencies() {
    final client =
        ModalRoute.of(context)!.settings.arguments as List<String>;

    formData['id'] = client[0];
    formData['name'] = client[1];
    formData['phone'] = client[2];
    formData['district'] = client[3];
    formData['street'] = client[4];
    formData['number'] = client[5];
    formData['due'] = client[6];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Endereço',
          style: context.textApp.appBarRegular,
        ),

        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 20,
          color: context.colors.tertiary,
        ),
      ),

      body: BlocConsumer<UpdateClientController, UpdateClientState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () {
              hideLoader();
            },
            updating: () => showLoader(),
            updated: () {
              hideLoader();
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/home',
                (route) => false,
              );
            },
            error: () {
              hideLoader();
              showErro(state.errorMessage ?? 'Erro não informado');
            },
          );
        },

        builder: (context, state) {
          return GestureDetector(
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
                            mainAxisAlignment: MainAxisAlignment.center,
  
                            children: [
          
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Input(
                                      label: 'Bairro',
                                      hintText: 'Digite o nome do bairro',
                                      initialValue: formData['district'].toString(),
                                      onSaved: (district) => formData['district'] = district ?? '',
                                      validator:
                                        Validatorless.required('Nome do bairro obrigatório'),
                                    ),
          
                                    const SizedBox(
                                      height: 20,
                                    ),
          
                                    Input(
                                      label: 'Rua',
                                      hintText:
                                        'Digite o nome da rua',
                                      initialValue: formData['street'].toString(),
                                      onSaved: (street) => formData['street'] = street ?? '',
                                      validator:
                                        Validatorless.required('Nome da rua obrigatório'),
                                    ),
          
                                    const SizedBox(
                                        height: 20,
                                    ),
  
                                    Input(
                                      label: 'Número',
                                      hintText:
                                        'Digite o número da casa',
                                      initialValue: formData['number'].toString(),
                                      onSaved: (number) => formData['number'] = number ?? '0',
                                      validator:
                                        Validatorless.required('Número da casa obrigatório'),
                                    ),
          
                                    const SizedBox(
                                        height: 20,
                                    ),
          
                                    SalesManagerButton(
                                      label: 'Salvar',
                                      onPressed: () {
                                        final valid =
                                          _formKey.currentState?.validate() 
                                          ?? false;
  
                                        if (valid) {
                                          _formKey.currentState?.save();
                                          controller.updateClient(
                                            formData['id'].toString(),
                                            formData['name'].toString(),
                                            formData['phone'].toString(),
                                            formData['district'].toString() ,
                                            formData['street'].toString(),
                                            int.tryParse(formData['number'].toString()) ?? 0,
                                            double.tryParse(formData['due'].toString()) ?? 0.0,
                                          );
                                        }
                                      },
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
          );
        },
      ),
    );
  }
}
