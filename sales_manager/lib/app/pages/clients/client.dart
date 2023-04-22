import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/client_card.dart';
import 'package:sales_manager/app/models/client_model.dart';

class Client extends StatefulWidget {
  final List<ClientModel> clients;
  final String route;

  const Client({
    super.key,
    required this.clients,
    required this.route,
  });

  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  final searchController = TextEditingController();
  late List<ClientModel> filteredClients;

  @override
  void initState() {
    filteredClients = widget.clients;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterClients(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredClients = widget.clients;
      } else {
        filteredClients = widget.clients
            .where((client) =>
                client.name.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                controller: searchController,
                onChanged: (value) => _filterClients(value),
                style: context.textApp.textPrimary.copyWith(color: Colors.black),
                
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
                itemCount: filteredClients.length,
                itemBuilder: (_, i) => ClientCard(
                  client: filteredClients.elementAt(i),
                  function: () => Navigator.of(context).pushNamed(
                    widget.route,
                    arguments: filteredClients.elementAt(i),
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
