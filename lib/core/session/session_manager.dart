import 'package:dailylog/core/session/pref_manager.dart';
import 'package:dailylog/core/utils/constant.dart';

class SessionManager {

  final PrefManager _prefManager;

  SessionManager(this._prefManager);

  String? get prefLanguage => _prefManager.getStringValue(Constant.prefLang);

  set prefLanguage(String? value) => _prefManager.saveString(Constant.prefLang, value ?? "");

  int? get familyMember => _prefManager.getIntValue(Constant.familyMember) ?? 1;

  set familyMember(int? member) => _prefManager.saveInt(Constant.familyMember, member ?? 1);

  double? get pricePerLitre => _prefManager.getDoubleValue(Constant.pricePerLiter) ?? Constant.perLitrePrice;

  set pricePerLitre(double? member) => _prefManager.saveDouble(Constant.pricePerLiter, member);

  void clearSession(){}
}