import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AlunosModel {
  final int id;
  final String nome;
  final String email;
  final String telefone;
  final double valor;
  final String senha;
  final String observacao;
  final bool situacao;
  const AlunosModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.valor,
    required this.senha,
    required this.observacao,
    required this.situacao
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'valor': valor,
      'senha': senha,
      'observacao': observacao,
      'situacao': situacao,
    };
  }

  factory AlunosModel.loadFromDB(Map<String, dynamic> aluno) {
    return AlunosModel(
      id: aluno['id'],
      nome: aluno['nome'] ?? '',
      email: aluno['email'] ?? '',
      telefone: aluno['telefone'] ?? '',
      valor: aluno['valor']?.toDouble() ?? 0.0,
      senha: aluno['senha'] ?? '',
      observacao: aluno['observacao'] ?? '',
      situacao: aluno['situacao'] == 1,
    );
  }

  factory AlunosModel.fromMap(Map<String, dynamic> map) {
    return AlunosModel(
      id: map['id']?.toInt() ?? 0,
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      telefone: map['telefone'] ?? '',
      valor: map['valor']?.toDouble() ?? 0.0,
      senha: map['senha'] ?? '',
      observacao: map['observacao'] ?? '',
      situacao: map['situacao'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlunosModel.fromJson(String source) => AlunosModel.fromMap(json.decode(source));

  AlunosModel copyWith({
    int? id,
    String? nome,
    String? email,
    String? telefone,
    double? valor,
    String? senha,
    String? observacao,
    bool? situacao,
  }) {
    return AlunosModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      valor: valor ?? this.valor,
      senha: senha ?? this.senha,
      observacao: observacao ?? this.observacao,
      situacao: situacao ?? this.situacao,
    );
  }
}
