import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';

class DataCard extends StatelessWidget {
  final List<String> data;
  final bool isUpdateIcon;
  final VoidCallback? onPressed;
  
  const DataCard({
    super.key,
    required this.data,
    this.isUpdateIcon = false, 
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  Text(data.elementAt(0), style: context.textApp.primaryRegular,),
                  const SizedBox(height: 10),
                  Text(data.elementAt(1), style: context.textApp.primaryRegular),
                  const SizedBox(height: 10),
                  Text(data.elementAt(2), style: context.textApp.primaryRegular),
                  const SizedBox(height: 10),
                  Text(data.elementAt(3), style: context.textApp.primaryRegular),
                ],
              ),
        
              isUpdateIcon ? Column(
                children: [
                  InkWell(
                    onTap: onPressed,
                    child: Icon(
                      Icons.edit,
                      color: context.colors.secundary,
                    ),
                  ),
                ],
              ) : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
