import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class Payment extends StatefulWidget {
  final ClientModel client;
  final SaleModel sale;

  const Payment({
    Key? key,
    required this.client,
    required this.sale,
  }) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends BaseState<Payment, PaymentController> {
  final paymentEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
// #userAuthRef
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
            loading: () => showLoader(),
            error: () {
              hideLoader();
              showErro(state.errorMessage ?? 'Erro não informado');
            },
          );
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),

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
                      widget.sale.productName,
                      style: context.textApp.primarySemiBold.copyWith(
                        color: context.colors.tertiary,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    DataCard(data: [
                      'Compra: ${widget.sale.day}',
                      'Quantidade: ${widget.sale.quantity}',
                      'Unidade: ${widget.sale.price}',
                      'Total: ${widget.sale.total}',
                    ]),
                  ],
                ),

                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Input(label: 'Digite o valor',
                        hintText: 'Ex: 12,00',
                        controller: paymentEC,
                      ),
                
                      const SizedBox(
                        height: 20,
                      ),
                
                      SalesManagerButton(
                        label: 'Pagar',
                        onPressed: () {
                          controller.payment(
                            widget.sale.id,
                            widget.client.id,
                            1,
                            double.tryParse(paymentEC.text) ?? 0.0,
                            widget.sale.total,
                            widget.client.due,
                            0,
                            200,
                            200,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
