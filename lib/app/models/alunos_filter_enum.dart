enum AlunosFilterEnum {
  emDia, 
  atrasados,
  cancelados,
}

extension AlunosFilterDescription on AlunosFilterEnum {
  String get description {
    switch(this) {
      case AlunosFilterEnum.emDia:
        return 'EM DIA';
      case AlunosFilterEnum.atrasados:
        return 'ATRASADOS';
      case AlunosFilterEnum.cancelados:
        return 'CANCELADOS';
    }
  }
}