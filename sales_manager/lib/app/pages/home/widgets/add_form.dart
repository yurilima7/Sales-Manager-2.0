import 'package:flutter/material.dart';
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
              onTap: () {
                clients.isNotEmpty ? Navigator.of(context).pushNamed(
                  '/clients',
                  arguments: {
                    'clients': clients,
                    'route': '/registerSale',
                  },
                ) : () {};
              },

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
              onTap: () => Navigator.of(context).pushNamed('/addClient'),
              child: Image.asset(
                'assets/images/AddClient.png',
                height: 50,
              ),
            ),

            const SizedBox(
              height: 11,
            ),

            Text(
              'Adicionar Cliente',
              style: context.textApp.littleTextPrimary,
            ),
          ],
        ),

        Column(
          children: [
            InkWell(
              onTap: () {
                clients.isNotEmpty ? Navigator.of(context).pushNamed(
                  '/clients',
                  arguments: {
                    'clients': clients,
                    'route': '/selPayment',
                  },
                ) : () {};
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
