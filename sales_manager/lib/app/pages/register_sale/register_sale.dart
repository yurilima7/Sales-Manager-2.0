import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/core/ui/base_state/base_state.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/input.dart';
import 'package:sales_manager/app/core/ui/widgets/insert_day.dart';
import 'package:sales_manager/app/core/ui/widgets/sales_manager_button.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/models/user_model.dart';
import 'package:sales_manager/app/pages/register_sale/register_sale_controller.dart';
import 'package:sales_manager/app/pages/register_sale/register_sale_state.dart';
import 'package:validatorless/validatorless.dart';

class RegisterSale extends StatefulWidget {
  final ClientModel clientModel;

  const RegisterSale({super.key, required this.clientModel});

  @override
  State<RegisterSale> createState() => _RegisterSaleState();
}

class _RegisterSaleState extends BaseState<RegisterSale, RegisterSaleController> {
  final _formKey = GlobalKey<FormState>();
  final _productNameEC = TextEditingController();
  final _priceEC = TextEditingController();
  final _quantityEC = TextEditingController();
  DateTime _day = DateTime.now();

  @override
  void onReady() {
    controller.load();
    super.onReady();
  }
  
  @override
  void dispose() {
    super.dispose();
    _productNameEC.dispose();
    _priceEC.dispose();
    _quantityEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar Venda',
          style: context.textApp.appBarRegular,
        ),

        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 20,
          color: context.colors.tertiary,
        ),
      ),
      
      body: BlocConsumer<RegisterSaleController, RegisterSaleState>(
        listener: (context, state) {
         state.status.matchAny(
            any: () {
              hideLoader();
            },
            loading: () => showLoader(),
            loaded: () {
              hideLoader();
            },
            registering: () => showLoader(),
            registered: () {
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
                                      label: 'Produto',
                                      hintText: 'Digite o nome do produto',
                                      controller: _productNameEC,
                                      validator:
                                        Validatorless.required('Nome do produto obrigatório'),
                                    ),
          
                                    const SizedBox(
                                      height: 20,
                                    ),
          
                                    Input(
                                      label: 'Preço',
                                      hintText:
                                        'Digite o preço do produto',
                                      controller: _priceEC,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        CentavosInputFormatter(moeda: true),
                                      ],
                                      validator:
                                        Validatorless.required('Preço do produto obrigatório'),
                                    ),
          
                                    const SizedBox(
                                        height: 20,
                                    ),
  
                                    Input(
                                      label: 'Quantidade',
                                      hintText:
                                        'Digite quantidade vendida',
                                      controller: _quantityEC,
                                      validator:
                                        Validatorless.required('Quantidade vendida obrigatória'),
                                    ),
          
                                    const SizedBox(
                                        height: 20,
                                    ),

                                    InsertDay(daySelect: _day, onDateChanged: (newData){
                                      setState(() {
                                        _day = newData;
                                      });
                                    }),

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
                                          controller.registerSale(
                                            widget.clientModel,
                                            state.user as UserModel,
                                            _productNameEC.text,
                                           UtilBrasilFields.converterMoedaParaDouble(_priceEC.text),
                                            int.tryParse(_quantityEC.text) ?? 0,
                                            _day.toString(),
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
