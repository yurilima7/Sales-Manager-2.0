import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/extensions/formater_extensions.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/models/client_model.dart';

class ClientCard extends StatelessWidget {
  final ClientModel client;
  final VoidCallback? function;

  const ClientCard({
    super.key,
    required this.client, 
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),

        child: ListTile(
          onTap: function,

          title: Text(
            client.name,
            style: context.textApp.primaryRegular,
          ),

          subtitle: Column(
            children: [
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  Text(
                    'Saldo Devedor',
                    style: context.textApp.primaryRegular,
                  ),

                  Text(
                    client.due.currencyPTBR,
                    style: context.textApp.primarySemiBold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
