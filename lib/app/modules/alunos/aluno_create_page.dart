// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:brasil_fields/brasil_fields.dart';
import 'package:devos_alunos_test/app/core/ui/helpers/context_extension.dart';
import 'package:devos_alunos_test/app/modules/alunos/aluno_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/notifier/default_listener_notifier.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../core/widget/aluno_list_field.dart';

class AlunoCreatePage extends StatefulWidget {
  final TaskCreateController _controller;

  AlunoCreatePage({
    Key? key,
    required TaskCreateController controller,
  })  : _controller = controller,
        super(key: key);

  @override
  State<AlunoCreatePage> createState() => _AlunoCreatePageState();
}

class _AlunoCreatePageState extends State<AlunoCreatePage> {
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

    // ignore: use_build_context_synchronously
    DefaultListenerNotifier(
      changeNotifier: widget._controller,
    ).listener(
        context: context,
        sucessVoidCallback: (notifier, listenerIstance) {
          listenerIstance.dispose();
          Navigator.pop(context);
        });
  }

  @override
  void dispose() {
    super.dispose();
    _nomeEC.dispose();
    _emailEC.dispose();
    _telefoneEC.dispose();
    _valorEC.dispose();
    _senhaEC.dispose();
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
            widget._controller.save(
                _nomeEC.text,
                _emailEC.text,
                _telefoneEC.text,
                UtilBrasilFields.converterMoedaParaDouble(_valorEC.text),
                _senhaEC.text,
                _observacaoEC.text);
          }
        },
        label: const Text(
          'Salvar Aluno',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                    'Cadastrar Aluno',
                    style: TextStyles.i.titleStyle.copyWith(
                      fontSize: 20,
                      color: context.primaryColorLight
                    ),
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(moeda: true),
                  ],
                  validator: Validatorless.required(
                      'Valor da Mensalidade é obrigatória'),
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
