import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sales_manager/app/core/extensions/formater_extensions.dart';
import 'package:sales_manager/app/core/ui/base_state/base_state.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/data_card.dart';
import 'package:sales_manager/app/core/ui/widgets/input.dart';
import 'package:sales_manager/app/core/ui/widgets/sales_manager_button.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/models/sale_model.dart';
import 'package:sales_manager/app/pages/payment/payment_controller.dart';
import 'package:sales_manager/app/pages/payment/payment_state.dart';
import 'package:validatorless/validatorless.dart';

class Payment extends StatefulWidget {

  const Payment({
    Key? key,
  }) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends BaseState<Payment, PaymentController> {
  final _paymentEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ClientModel? client;
  SaleModel? sale;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments 
                    as Map<String, dynamic>;

    client = args['client'] as ClientModel;
    sale = args['sale'] as SaleModel;
  }

  @override
  void onReady() {
    controller.load();
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registrar Pagamento',
          style: context.textApp.appBarRegular,
        ),

        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 20,
          color: context.colors.tertiary,
        ),
      ),

      body: BlocConsumer<PaymentController, PaymentState>(
        listener: (context, state) {
         state.status.matchAny(
            any: () {
              hideLoader();
            },
            paying: () => showLoader(),
            loading: () => showLoader(),
            paid: () {
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
            padding: const EdgeInsets.all(20),

            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
            
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
            
                      Text(
                        sale!.productName,
                        style: context.textApp.primarySemiBold.copyWith(
                          color: context.colors.tertiary,
                        ),
                      ),
            
                      const SizedBox(
                        height: 8,
                      ),
            
                      DataCard(data: [
                        'Compra: ${DateFormat('dd/MM/y').format(DateTime.parse(sale!.day))}',
                        'Quantidade: ${sale!.quantity}',
                        'Unidade: ${sale!.price.currencyPTBR}',
                        'Total: ${sale!.total.currencyPTBR}',
                      ]),
                    ],
                  ),

                  const SizedBox(
                    height: 8,
                  ),
            
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Input(label: 'Digite o valor',
                          hintText: 'Ex: R\$ 12,00',
                          controller: _paymentEC,
                           inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CentavosInputFormatter(moeda: true),
                            ],
                          validator: Validatorless.multiple([
                            Validatorless.required('Valor obrigatório'),
                          ]),
                        ),
                  
                        const SizedBox(
                          height: 20,
                        ),
                  
                        SalesManagerButton(
                          label: 'Pagar',
                          onPressed: () {
                            final valid =
                                _formKey.currentState?.validate() ?? false;
                            final value = UtilBrasilFields.converterMoedaParaDouble(_paymentEC.text);
                            
                            if (valid && (state.user != null ? true : false) && (value > 0.01 && value < 50.01)) {
                              controller.payment(
                                sale!.id,
                                client!.id,
                                state.user!.id,
                                value,
                                sale!.total,
                                client!.due,
                                state.user!.recebido ,
                                state.user!.receber,
                                state.user!.totalVendido,
                              );
                            } else {
                              showInfo(
                                  'Valor não está no intervalo de R\$ 0,01 e R\$ ${sale!.total}');
                            }
                          },
                        ),
                      ],
                    ),
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
