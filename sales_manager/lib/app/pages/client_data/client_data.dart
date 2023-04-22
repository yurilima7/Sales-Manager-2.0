import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/core/ui/base_state/base_state.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/data_card.dart';
import 'package:sales_manager/app/core/ui/widgets/sale_card.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/pages/client_data/client_data_controller.dart';
import 'package:sales_manager/app/pages/client_data/client_data_state.dart';

class ClientData extends StatefulWidget {
  const ClientData({super.key});

  @override
  State<ClientData> createState() => _ClientDataState();
}

class _ClientDataState extends BaseState<ClientData, ClientDataController> {
  ClientModel? client;
  bool _isLoading = true;
  
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
          client!.name,
          style: context.textApp.appBarRegular,
        ),
        
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 20,
          color: context.colors.tertiary,
        ),

        actions: [
          IconButton(
            onPressed: () => controller.deleteClient(client!),

            icon: Image.asset(
              'assets/images/delete.png',
              height: 24,
            ),
          ),
        ],
      ),

      body: BlocConsumer<ClientDataController, ClientDataState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () {
              _isLoading = false;
              hideLoader();
            },
            loading: () => showLoader(),
            deleting: () => showLoader(),
            deleted: () {
              hideLoader();
              showSuccess('Cliente deletado com sucesso!');
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
            },
            error: () {
              _isLoading = false;
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
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10,),
        
            child: SingleChildScrollView(
              child: Visibility(
                visible: !_isLoading,
                
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
                        'Telefone: ${client!.phone}',
                        'Bairro ${client!.district}',
                        'Rua: ${client!.street}',
                        'N°: ${client!.number}',
                      ],
                      isUpdateIcon: true,
                        onPressed: () => Navigator.of(context).pushNamed(
                          '/updateClient',
                          arguments: client,
                        ),
                    ),
                          
                    const SizedBox(
                      height: 35,
                    ),
                          
                    Text(
                      'Compras',
                      style: context.textApp.primarySemiBold.copyWith(
                        color: context.colors.tertiary,
                      ),
                    ),
                      
                    const SizedBox(
                      height: 8,
                    ),
                      
                    Visibility(
                      visible: state.sales!.isNotEmpty,
              
                      replacement: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
              
                        child: Center(
                          child: Text(
                              'Não existem compras realizadas',
                              style: context.textApp.primarySemiBold.copyWith(
                                color: context.colors.tertiary,
                              ),
                            ),
                        ),
                      ),
                      
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.sales!.length,
                        itemBuilder: (_, i) => SaleCard(
                          sale: state.sales!.elementAt(i),
                            onPressed: () => Navigator.of(context).pushNamed(
                              '/productData',
                              arguments: {
                                'client': client,
                                'sale': state.sales!.elementAt(i),
                              }
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
