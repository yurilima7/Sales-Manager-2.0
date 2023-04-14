// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/models/sale_model.dart';

class AddForm extends StatelessWidget {
  final List<ClientModel> clients;
  final List<SaleModel> sales;

  const AddForm({
    Key? key,
    required this.clients,
    required this.sales,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Column(
          children: [
            InkWell(
              onTap: () => showModalBottomSheet<void>(
                context: context,
                builder: (_) => Container(
                  color: context.colors.primary,
                  height: 150,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'Clique na opção desejada',
                          style: context.textApp.textPrimaryLight,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed(
                            '/clients',
                            arguments: {
                              'clients': clients,
                              'route': '/selPayment',
                            },
                          );
                        },

                        child: Text(
                          'Cliente existente',
                          style:
                              context.textApp.textPrimaryLight,
                        ),
                      ),

                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Novo cliente',
                          style:
                              context.textApp.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              child: Image.asset(
                'assets/images/Add-Venda.png',
                height: 50,
              ),
            ),
                          
            const SizedBox(
              height: 11,
            ),
                          
            Text(
              'Adicionar Venda',
              style: context.textApp.littleTextPrimary,
            ),
          ],
        ),

        Column(
          children: [
            InkWell(
              onTap: () {
                
              },
              child: Image.asset(
                'assets/images/Add-Pag.png',
                height: 50,
              ),
            ),

            const SizedBox(
              height: 11,
            ),

            Text(
              'Adicionar Pagamento',
              style: context.textApp.littleTextPrimary,
            ),
          ],
        ),
      ],
    );
  }
}
