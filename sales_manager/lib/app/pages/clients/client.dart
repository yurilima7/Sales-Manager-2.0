import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/client_card.dart';
import 'package:sales_manager/app/models/client_model.dart';

class Client extends StatefulWidget {
  final List<ClientModel> clients;

  const Client({super.key, required this.clients});

  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  Widget build(BuildContext context) {
    final clients = widget.clients;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clientes',
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
            children: [
              const SizedBox(
                 height: 40,
              ),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Buscar cliente',
                  hintText: 'Digite o nome do cliente',
                  fillColor: context.colors.tertiary,
                  suffixIcon: const Icon(Icons.search),
                ),
              ),

              const SizedBox(
                height: 36,
              ),
              
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.clients.length,
                itemBuilder: (_, i) => ClientCard(
                  client: clients.elementAt(i),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
