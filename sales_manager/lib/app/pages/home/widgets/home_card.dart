import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? function;

  const HomeCard({
    super.key,
    required this.title,
    required this.subtitle, 
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
    
        child: ListTile(
          onTap: function,
          
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
    
            children: [
              Text(
                title,
                style: context.textApp.textPrimary,
              ),
        
              const SizedBox(
                  height: 16,
              ),
        
              Text(
                subtitle,
                style: context.textApp.textCardTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
