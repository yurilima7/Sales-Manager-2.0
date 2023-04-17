import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/models/sale_model.dart';

class SaleCard extends StatelessWidget {
  final SaleModel sale;
  final VoidCallback? onPressed;

  const SaleCard({
    super.key,
    required this.sale, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),

        child: ListTile(
          onTap: onPressed,

          title: Text(
            sale.productName,
            style: context.textApp.primaryRegular,
          ),

          subtitle: Column(
            children: [
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  Text(
                    'Valor unitário',
                    style: context.textApp.primaryRegular,
                  ),

                  Text(
                    sale.price.toString(),
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
