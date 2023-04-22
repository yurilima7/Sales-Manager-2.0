import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/base_state/base_state.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:sales_manager/app/models/sale_model.dart';
import 'package:sales_manager/app/pages/home/home_controller.dart';

class AddForm extends StatefulWidget {
  final List<ClientModel> clients;
  final List<SaleModel> sales;

  const AddForm({
    Key? key,
    required this.clients,
    required this.sales,
  }) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends BaseState<AddForm, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Column(
          children: [
            InkWell(
              onTap: () {
                widget.clients.isNotEmpty ? Navigator.of(context).pushNamed(
                  '/clients',
                  arguments: {
                    'clients': widget.clients,
                    'route': '/registerSale',
                  },
                ) : showInfo('Impossível adicionar venda, não existem clientes cadastrados!');
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
              'Nova Venda',
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
                widget.clients.isNotEmpty ? Navigator.of(context).pushNamed(
                  '/clients',
                  arguments: {
                    'clients': widget.clients,
                    'route': '/selPayment',
                  },
                ) : showInfo('Impossível adicionar pagamento, não existem clientes cadastrados!');
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
              'Novo Pagamento',
              style: context.textApp.littleTextPrimary,
            ),
          ],
        ),
      ],
    );
  }
}
