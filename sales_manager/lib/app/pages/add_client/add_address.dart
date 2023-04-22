import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/core/ui/base_state/base_state.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/input.dart';
import 'package:sales_manager/app/core/ui/widgets/sales_manager_button.dart';
import 'package:sales_manager/app/pages/add_client/add_client_controller.dart';
import 'package:sales_manager/app/pages/add_client/add_client_state.dart';
import 'package:validatorless/validatorless.dart';

class AddAddress extends StatefulWidget {
  final List<String> clientData;

  const AddAddress({super.key, required this.clientData});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends BaseState<AddAddress, AddClientController> {
  final _formKey = GlobalKey<FormState>();
  final _districtEC = TextEditingController();
  final _streetEC = TextEditingController();
  final _numberEC = TextEditingController();
  
  @override
  void dispose() {
    super.dispose();
    _districtEC.dispose();
    _streetEC.dispose();
    _numberEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar Endereço',
          style: context.textApp.appBarRegular,
        ),

        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 20,
          color: context.colors.tertiary,
        ),
      ),
      
      body: BlocConsumer<AddClientController, AddClientState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () {
              hideLoader();
            },
            registering: () => showLoader(),
            registered: () {
              hideLoader();
              showSuccess('Cliente registrado com sucesso!');
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
                                          controller: _districtEC,
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
                                          controller: _streetEC,
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
                                          controller: _numberEC,
                                          validator:
                                            Validatorless.required('Número da casa obrigatório'),
                                        ),
              
                                        const SizedBox(
                                           height: 20,
                                        ),
              
                                        SalesManagerButton(
                                          label: 'Continuar',
                                          onPressed: () {
                                            final valid =
                                              _formKey.currentState?.validate() 
                                              ?? false;
      
                                            if (valid) {
                                              controller.registerClient(
                                                widget.clientData[0],
                                                widget.clientData[1],
                                                _districtEC.text,
                                                _streetEC.text,
                                                int.tryParse(_numberEC.text) ?? 0,
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
