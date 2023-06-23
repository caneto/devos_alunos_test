// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:brasil_fields/brasil_fields.dart';
import 'package:devos_alunos_test/app/core/ui/theme_extensions.dart';
import 'package:devos_alunos_test/app/modules/home/widgets/aluno.dart';
import 'package:devos_alunos_test/app/modules/tasks/aluno_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/notifier/default_listener_notifier.dart';
import '../../core/widget/todo_list_field.dart';
import '../../models/alunos_model.dart';

class AlunoEditPage extends StatefulWidget {
  final TaskCreateController _controller;
  
  AlunoEditPage({
    Key? key,
    required TaskCreateController controller,
  })  : _controller = controller,
        super(key: key);

  @override
  State<AlunoEditPage> createState() => _AlunoEditPageState();
}

class _AlunoEditPageState extends State<AlunoEditPage> {

  int? alunoId;
  
  final _nomeEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _telefoneEC = TextEditingController();
  final _valorEC = TextEditingController();
  final _senhaEC = TextEditingController();
  final _observacaoEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
     
    load(); 

    // ignore: use_build_context_synchronously
    DefaultListenerNotifier(
      changeNotifier: widget._controller,
    ).listener(context: context, sucessVoidCallback: (notifier, listenerIstance) {
      listenerIstance.dispose();
      Navigator.pop(context);
    });
  }

  Future load() async {
    final sp = await SharedPreferences.getInstance();
    alunoId = sp.getInt('alunoId') ;

    if(alunoId != 0) {
      Future<AlunosModel?> aluno = widget._controller.findbyId(alunoId: alunoId!);
      print(aluno);
     // _nomeEC.text = widget._controller.aluno!.nome; 
      
    }
    
  }

  @override
  void dispose() {
    super.dispose();
    _nomeEC.dispose();
    _emailEC.dispose();
    _telefoneEC.dispose();
    _valorEC.dispose();
    _senhaEC.dispose();
    _observacaoEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.primaryColor,
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            widget._controller.save(_nomeEC.text,_emailEC.text,_telefoneEC.text, UtilBrasilFields.converterMoedaParaDouble(_valorEC.text), _senhaEC.text, _observacaoEC.text);
          }
        },
        label: const Text(
          'Salvar Aluno',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Edicão Aluno',
                    style: context.titleStyle.copyWith(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AlunoListField(
                  controller: _nomeEC,
                  keyboardType: TextInputType.name,
                  validator: Validatorless.required('Nome é obrigatória'),
                  label: 'Nome',
                ),
                const SizedBox(
                  height: 20,
                ),
                AlunoListField(
                  controller: _emailEC,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validatorless.required('Email é obrigatória'),
                  label: 'E-Mail',
                ),
                const SizedBox(
                  height: 20,
                ),
                AlunoListField(
                  controller: _telefoneEC,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  validator: Validatorless.required('Telefone é obrigatória'),
                  label: 'Telefone',
                ),
                const SizedBox(
                  height: 20,
                ),
                AlunoListField(
                  controller: _senhaEC,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: Validatorless.required('Senha é obrigatória'),
                  label: 'Senha',
                ),
                const SizedBox(
                  height: 20,
                ),
                AlunoListField(
                  controller: _observacaoEC,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  validator: Validatorless.required('observação é obrigatória'),
                  label: 'Observacação',
                ),
                const SizedBox(
                  height: 20,
                ),
                AlunoListField(
                  controller: _valorEC,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(),
                  ],
                  validator: Validatorless.required('Valor da Mensalidade é obrigatória'),
                  label: 'Mensalidade',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
