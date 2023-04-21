import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_manager/app/core/ui/styles/colors_app.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';
import 'package:sales_manager/app/core/ui/widgets/input.dart';
import 'package:sales_manager/app/core/ui/widgets/sales_manager_button.dart';
import 'package:sales_manager/app/models/client_model.dart';
import 'package:validatorless/validatorless.dart';

class UpdateClient extends StatefulWidget {
  const UpdateClient({super.key});

  @override
  State<UpdateClient> createState() => _UpdateClientState();
}

class _UpdateClientState extends State<UpdateClient> {
  final _formKey = GlobalKey<FormState>();
  final formData = <String, Object>{};
  ClientModel? client;

  @override
  void didChangeDependencies() {
    final client =
        ModalRoute.of(context)!.settings.arguments as ClientModel;


    formData['id'] = client.id;
    formData['district'] = client.district;
    formData['name'] = client.name;
    formData['number'] = client.number;
    formData['street'] = client.street;
    formData['due'] = client.due;
    formData['phone'] = client.phone;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Cliente',
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
                                  initialValue: formData['name'].toString(),
                                  onSaved: (name) => formData['name'] = name ?? '',
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
                                  initialValue: formData['phone'].toString(),
                                  onSaved: (phone) => formData['phone'] = phone ?? '',
                                  inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      TelefoneInputFormatter(),
                                    ],
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
                                      _formKey.currentState?.save();
                                      
                                      Navigator.of(context).pushNamed(
                                        '/updateAddress',
                                        arguments: [
                                          formData['id'].toString(),
                                          formData['name'].toString(),
                                          formData['phone'].toString(),
                                          formData['district'].toString() ,
                                          formData['street'].toString(),
                                          formData['number'].toString(),
                                          formData['due'].toString(),
                                        ],
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
