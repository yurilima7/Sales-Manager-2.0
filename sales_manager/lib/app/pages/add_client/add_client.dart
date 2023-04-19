import 'package:flutter/material.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/input.dart';
import 'package:sales_manager/app/core/ui/widgets/sales_manager_button.dart';
import 'package:validatorless/validatorless.dart';

class AddClient extends StatefulWidget {
  const AddClient({super.key});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _phoneEC = TextEditingController();
  
  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _phoneEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar Cliente',
          style: context.textApp.appBarRegular,
        ),

        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 20,
          color: context.colors.tertiary,
        ),
      ),
      
      body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
        
                child: LayoutBuilder(
                  builder: (_, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
        
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
        
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Input(
                                    label: 'Nome',
                                    hintText: 'Digite o nome do cliente',
                                    controller: _nameEC,
                                    validator:
                                      Validatorless.required('Nome obrigatório'),
                                  ),
        
                                  const SizedBox(
                                    height: 20,
                                  ),
        
                                  Input(
                                    label: 'Telefone',
                                    hintText:
                                      'Digite o número de telefone do cliente',
                                    controller: _phoneEC,
                                    validator:
                                      Validatorless.required('Telefone obrigatório'),
                                  ),
        
                                  const SizedBox(
                                     height: 20,
                                  ),
        
                                  SalesManagerButton(
                                    label: 'Continuar',
                                    onPressed: () {
                                      final valid =
                                        _formKey.currentState?.validate() 
                                        ?? false;

                                      if (valid) {
                                        Navigator.of(context).pushNamed(
                                          '/addAddress',
                                          arguments: [_nameEC.text, _phoneEC.text],
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
