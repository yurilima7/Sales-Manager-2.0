import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/core/ui/base_state/base_state.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/sale_card.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/pages/select_to_payment/select_to_payment_controller.dart';
import 'package:sales_manager/app/pages/select_to_payment/select_to_payment_state.dart';

class SelectToPayment extends StatefulWidget {

  const SelectToPayment({super.key});

  @override
  State<SelectToPayment> createState() => _SelectToPaymentState();
}

class _SelectToPaymentState
    extends BaseState<SelectToPayment, SelectToPaymentController> {

  ClientModel? client;
  bool isLoading = true;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    client = ModalRoute.of(context)!.settings.arguments 
                    as ClientModel;
  }

  @override
  void onReady() {
    controller.load(client!.id);
    super.onReady();
  }
      
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecionar para pagamento',
          style: context.textApp.appBarRegular,
        ),

        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 20,
          color: context.colors.tertiary,
        ),
      ),

      body: BlocConsumer<SelectToPaymentController, SelectToPaymentState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () {
              isLoading = false;
              hideLoader();
            },
            loading: () => showLoader(),
            error: () {
              isLoading = false;
              hideLoader();
              showErro(state.errorMessage ?? 'Erro não informado');
            },
          );
        },

        buildWhen: (previous, current) => current.status.matchAny(
          any: () => false,
          initial: () => true,
          loaded: () => true,
        ),

        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
              bottom: 10,
            ),

            child: Visibility(
              visible: state.sales!.isNotEmpty,

              replacement: !isLoading ? Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,

                    child: Center(
                      child: Text(
                          'Não existem compras realizadas',
                          style: context.textApp.primarySemiBold.copyWith(
                            color: context.colors.tertiary,
                          ),
                        ),
                    ),
                  ),
                ],
              ) : const SizedBox.shrink(),
              
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.sales!.length,
                  itemBuilder: (_, i) => SaleCard(
                    sale: state.sales!.elementAt(i),
                    onPressed: () => Navigator.of(context).pushNamed(
                      '/payment',
                      arguments: {
                        'client': client,
                        'sale': state.sales!.elementAt(i),
                      },
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
