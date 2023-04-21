import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/core/extensions/formater_extensions.dart';
import 'package:sales_manager/app/core/ui/base_state/base_state.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/data_card.dart';
import 'package:sales_manager/app/core/ui/widgets/input.dart';
import 'package:sales_manager/app/core/ui/widgets/insert_day.dart';
import 'package:sales_manager/app/core/ui/widgets/sales_manager_button.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/models/sale_model.dart';
import 'package:sales_manager/app/pages/product_data/product_data_controller.dart';
import 'package:sales_manager/app/pages/product_data/product_data_state.dart';
import 'package:validatorless/validatorless.dart';

class ProductData extends StatefulWidget {

  const ProductData({
    super.key,
  });

  @override
  State<ProductData> createState() => _ProductDataState();
}

class _ProductDataState extends BaseState<ProductData, ProductDataController> {
  final _formKey = GlobalKey<FormState>();
  final formData = <String, Object>{};
  ClientModel? client;
  SaleModel? sale;

  @override
  void onReady() {
    controller.load();
    super.onReady();
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments 
                    as Map<String, dynamic>;

    client = args['client'] as ClientModel;
    sale = args['sale'] as SaleModel;

    formData['id'] = sale!.id;
    formData['productName'] = sale!.productName;
    formData['quantity'] = sale!.quantity;
    formData['price'] = sale!.price;
    formData['total'] = sale!.total;
    formData['day'] = sale!.day;
    formData['clientId'] = sale!.clientId;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          sale?.productName ?? '',
          style: context.textApp.appBarRegular,
        ),

        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 20,
          color: context.colors.tertiary,
        ),
      ),

      body: BlocConsumer<ProductDataController, ProductDataState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () {
              hideLoader();
            },
            loading: () => showLoader(),
            loaded: () {
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
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10,),
        
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
        
                children: [
                  const SizedBox(
                    height: 40,
                  ),
        
                  Text(
                    'Dados',
                    style: context.textApp.primarySemiBold.copyWith(
                      color: context.colors.tertiary,
                    ),
                  ),
                    
                  const SizedBox(
                    height: 8,
                  ),
                    
                  DataCard(
                    data: [
                      'Compra: ${sale?.productName ?? ''}',
                      'Quantidade ${sale?.quantity ?? ''}',
                      'Unidade: ${sale?.price.currencyPTBR ?? ''}',
                      'Valor total: ${sale?.total.currencyPTBR ?? ''}',
                    ],
                  ),
            
                  const SizedBox(
                    height: 35,
                  ),
            
                  Text(
                    'Edição de dados',
                    style: context.textApp.primarySemiBold.copyWith(
                      color: context.colors.tertiary,
                    ),
                  ),
        
                  const SizedBox(
                    height: 8,
                  ),
        
                  Form(
                    key: _formKey,

                    child: Column(
                      children: [
                        Input(
                          label: 'Produto',
                          hintText: 'Digite o nome do produto',
                          initialValue: formData['productName'].toString(),
                          onSaved: (name) => formData['productName'] = name ?? '',
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
                          initialValue: (formData['price'] as double).currencyPTBR,
                          onSaved: (price) => formData['price'] = price ?? 0.0,
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
                          initialValue: formData['quantity'].toString(),
                          onSaved: (quantity) => formData['quantity'] = quantity ?? 0,
                          validator:
                            Validatorless.required('Quantidade vendida obrigatória'),
                        ),

                        const SizedBox(
                            height: 20,
                        ),

                        InsertDay(daySelect: DateTime.parse(formData['day'].toString()), onDateChanged: (newData){
                          setState(() {
                            formData['day'] = newData;
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
                                _formKey.currentState?.save();
                                final newSalePrice = formData['price'].toString().removeCurrencyFormat();
                               
                                controller.productUpdate(
                                  sale!.id,
                                  client!,
                                  state.user!,
                                  formData['productName'].toString(),
                                  double.tryParse(newSalePrice) ?? 0,
                                  sale!.price,
                                  int.tryParse(formData['quantity'].toString()) ?? 0,
                                  sale!.quantity,
                                  formData['day'].toString(),
                                  sale!.total
                                );
                              }
                            },
                          ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
