import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/extensions/formater_extensions.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/data_card.dart';
import 'package:sales_manager/app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends StatefulWidget {
  final UserModel user;

  const UserData({super.key, required this.user});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.name,
          style: context.textApp.appBarRegular,
        ),

        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 20,
          color: context.colors.tertiary,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10,),
        
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                  height: 40,
              ),
              
              Text(
                'Dados Usuário',
                style: context.textApp.primarySemiBold.copyWith(
                  color: context.colors.tertiary,
                ),
              ),
                
              const SizedBox(
                height: 8,
              ),
        
              DataCard(
                data: [
                  'INFORMAÇÕES',
                  'Nome: ${widget.user.name}',
                  'Email: ${widget.user.email}',
                  '',
                ],
              ),

              const SizedBox(
                  height: 20,
              ),
              
              Text(
                'Valores',
                style: context.textApp.primarySemiBold.copyWith(
                  color: context.colors.tertiary,
                ),
              ),
                
              const SizedBox(
                height: 8,
              ),
        
              DataCard(
                data: [
                  'Total a receber: ${widget.user.receber.currencyPTBR}',
                  'Recebido ${widget.user.recebido.currencyPTBR}',
                  'Total vendido ${widget.user.totalVendido.currencyPTBR}',
                  '',
                ],
              ),

              const SizedBox(
                  height: 20,
              ),
              
              Text(
                'Configurações',
                style: context.textApp.primarySemiBold.copyWith(
                  color: context.colors.tertiary,
                ),
              ),
                
              const SizedBox(
                height: 8,
              ),
        
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
        
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          
                          children: [
                            
                            InkWell(
                              onTap: () async { 
                                final sp = await SharedPreferences.getInstance();
                                sp.clear();

                                nav.pushNamedAndRemoveUntil(
                                      '/auth/login', (route) => false);
                              },

                              child: Text('Sair',
                                  style: context.textApp.primaryRegular),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
