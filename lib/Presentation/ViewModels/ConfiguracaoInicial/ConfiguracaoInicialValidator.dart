import 'package:fluent_validation/factories/abstract_validator.dart';
import 'package:kayta_flutter/Models/ConfiguracaoInicialModel.dart';

class ConfiguracaoInicialValidator extends AbstractValidator<ConfiguracaoInicialModel> {
  ConfiguracaoInicialValidator(int etapa) {
    if (etapa == 1) {
      ruleFor((e) => e.enderecoDoServidor).notEmpty().withMessage('O endereço do servidor é obrigatório');
    } else if (etapa == 2) {
      ruleFor((e) => e.portaDoServidor).notEmpty().withMessage('A porta do servidor é obrigatório');
    } else if (etapa == 3) {
      ruleFor((e) => e.ambienteDoServidor).notEmpty().withMessage('O ambiente do servidor é obrigatório');
    }
  }
}
