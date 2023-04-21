import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_manager/app/core/ui/base_state/base_state.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/pages/home/home_controller.dart';
import 'package:sales_manager/app/pages/home/home_state.dart';
import 'package:sales_manager/app/pages/home/widgets/add_form.dart';
import 'package:sales_manager/app/pages/home/widgets/home_card.dart';
import 'package:sales_manager/app/pages/home/widgets/user_card.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends BaseState<Home, HomeController> {
  bool _isLoading = true;
  
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
            loaded: () {
              _isLoading = false;
              hideLoader();
            },
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
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 5),

            child: SingleChildScrollView(
              child: Column(
                children: [ 

                  _isLoading 
                    ? Shimmer.fromColors(
                        enabled: _isLoading,
                        baseColor: Colors.blueGrey,
                        highlightColor: Colors.white,

                        child: const UserCard(),
                      )
                      : UserCard(user: state.user),
              
                  const SizedBox(
                     height: 60,
                  ),
              
                  _isLoading 
                    ? Shimmer.fromColors(
                      enabled: _isLoading,
                      baseColor: Colors.blueGrey,
                      highlightColor: Colors.white,

                      child: const AddForm(clients: [], sales: [],),
                    ) 
                    : AddForm(
                        clients: state.clients ?? [],
                        sales: state.sales ?? [],
                      ),
              
                  const SizedBox(
                    height: 60,
                  ),

                  _isLoading 
                    ? Shimmer.fromColors(
                      enabled: _isLoading,
                      baseColor: Colors.blueGrey,
                      highlightColor: Colors.white,

                      child: const HomeCard(title: '', subtitle: ''),
                    ) 
                    : 
                    HomeCard(
                      title: 'Clientes',
                      subtitle: state.clients?.length.toString() ?? '',
                      function: state.clients!.isNotEmpty ? () => Navigator.of(context).pushNamed(
                        '/clients',
                        arguments: {
                          'clients': state.clients,
                          'route': '/clientData',
                        },
                      ) : () {},
                    ),
              
                  const SizedBox(
                    height: 10,
                  ),

                  _isLoading 
                    ? Shimmer.fromColors(
                      enabled: _isLoading,
                      baseColor: Colors.blueGrey,
                      highlightColor: Colors.white,

                      child: const AddForm(clients: [], sales: [],),
                    ) 
                    : 
                    HomeCard(
                      title: 'Vendas',
                      subtitle: state.sales?.length.toString() ?? '',
                      function: state.sales!.isNotEmpty ? () => Navigator.of(context).pushNamed(
                        '/sales',
                        arguments: state.sales
                    ) :() {},
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
