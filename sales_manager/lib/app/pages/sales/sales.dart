import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/extensions/formater_extensions.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/models/sale_model.dart';

class Sales extends StatefulWidget {
  final List<SaleModel> sales;

  const Sales({
    super.key,
    required this.sales,
  });

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  Widget build(BuildContext context) {
    final sales = widget.sales;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vendas Recentes',
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
              
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sales.length,
                itemBuilder: (_, i) => Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),

                    child: ListTile(
                      title: Text(
                        sales.elementAt(i).productName,
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
                                sales.elementAt(i).price.currencyPTBR,
                                style: context.textApp.primarySemiBold,
                              ),
                            ],
                          ),
                        ],
                      ),
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
