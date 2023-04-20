import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/core/ui/base_state/base_state.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/pages/home/home_controller.dart';
import 'package:sales_manager/app/pages/home/home_state.dart';
import 'package:sales_manager/app/pages/home/widgets/add_form.dart';
import 'package:sales_manager/app/pages/home/widgets/home_card.dart';
import 'package:sales_manager/app/pages/home/widgets/user_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends BaseState<Home, HomeController> {
  @override
  void onReady() {
    controller.load();
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sales Manager', style: context.textApp.appBarHome,),
      ),

      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            error: () {
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
            padding: const EdgeInsets.all(20.0),

            child: LayoutBuilder(
              builder: (_, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
          
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        UserCard(user: state.user),
                    
                        SizedBox(
                           height: constraints.maxHeight * .08,
                        ),
                    
                        AddForm(
                          clients: state.clients ?? [],
                          sales: state.sales ?? [],
                        ),
                    
                        SizedBox(
                          height: constraints.maxHeight * .08,
                        ),
                    
                        HomeCard(
                          title: 'Clientes',
                          subtitle: state.clients?.length.toString() ?? '',
                          function: () => Navigator.of(context).pushNamed(
                            '/clients',
                            arguments: {
                              'clients': state.clients,
                              'route': '/clientData',
                            },
                          ),
                        ),
                    
                        SizedBox(
                          height: constraints.maxHeight * .08,
                        ),
                    
                        HomeCard(
                          title: 'Vendas',
                          subtitle: state.sales?.length.toString() ?? '',
                          function: () => Navigator.of(context).pushNamed(
                            '/sales',
                            arguments: state.sales
                          ),
                        ),
                      ],
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
