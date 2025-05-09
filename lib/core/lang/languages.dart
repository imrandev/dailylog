import 'package:get/get.dart';
import 'package:dailylog/core/lang/app_localization.dart';

class Languages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    "en": {
      AppLocalization.dailyAverageCost: AppLocalization.dailyAverageCost.replaceAll("_", " "),
      AppLocalization.lastAverageMonthlyCost: AppLocalization.lastAverageMonthlyCost.replaceAll("_", " "),
      AppLocalization.dailyWaterIntake: AppLocalization.dailyWaterIntake.replaceAll("_", " "),
      AppLocalization.electricityMeter: AppLocalization.electricityMeter.replaceAll("_", " "),
      AppLocalization.cylinderGas: AppLocalization.cylinderGas.replaceAll("_", " "),
      AppLocalization.waterPump: AppLocalization.waterPump.replaceAll("_", " "),
      AppLocalization.drinkingWater: AppLocalization.drinkingWater.replaceAll("_", " "),
      AppLocalization.itMayContinueFor: AppLocalization.itMayContinueFor.replaceAll("_", " "),
      AppLocalization.days: AppLocalization.days.replaceAll("_", " "),
      AppLocalization.day: AppLocalization.day.replaceAll("_", " "),
      AppLocalization.tk: AppLocalization.tk.replaceAll("_", " "),
      AppLocalization.settings: AppLocalization.settings.replaceAll("_", " "),
      AppLocalization.dailyLog: AppLocalization.dailyLog.replaceAll("_", " "),
      AppLocalization.switchLanguage: AppLocalization.switchLanguage.replaceAll("_", " "),
      AppLocalization.electricityLogs: AppLocalization.electricityLogs.replaceAll("_", " "),
      AppLocalization.entryLog: AppLocalization.entryLog.replaceAll("_", " "),
      AppLocalization.hintElectricityField: AppLocalization.hintElectricityField.replaceAll("_", " "),
      AppLocalization.hintGasField: AppLocalization.hintGasField.replaceAll("_", " "),
      AppLocalization.hintCalendarField: AppLocalization.hintCalendarField.replaceAll("_", " "),
      AppLocalization.edit: AppLocalization.edit.replaceAll("_", " "),
      AppLocalization.delete: AppLocalization.delete.replaceAll("_", " "),
      AppLocalization.newFeature: AppLocalization.newFeature.replaceAll("_", " "),
      AppLocalization.comingSoon: AppLocalization.comingSoon.replaceAll("_", " "),
      AppLocalization.submit: AppLocalization.submit.replaceAll("_", " "),
      AppLocalization.noDataFound: AppLocalization.noDataFound.replaceAll("_", " "),
      AppLocalization.errorElectricityBalance: AppLocalization.errorElectricityBalance.replaceAll("_", " "),
      AppLocalization.errorGasPrice: AppLocalization.errorGasPrice.replaceAll("_", " "),
      AppLocalization.defaultLanguage: AppLocalization.defaultLanguage.replaceAll("_", " "),
      AppLocalization.errorWaterPumpAmount: AppLocalization.errorWaterPumpAmount.replaceAll("_", " "),
      AppLocalization.hintWaterAmountField: AppLocalization.hintWaterAmountField.replaceAll("_", " "),
      AppLocalization.hintWaterBalanceField: AppLocalization.hintWaterBalanceField.replaceAll("_", " "),
      AppLocalization.newBalance: AppLocalization.newBalance.replaceAll("_", " "),
      AppLocalization.errorWaterAtmBalance: AppLocalization.errorWaterAtmBalance.replaceAll("_", " "),
      AppLocalization.possibleWaterBalance: AppLocalization.possibleWaterBalance.replaceAll("_", " "),
      AppLocalization.rechargeWaterCard: AppLocalization.rechargeWaterCard.replaceAll("_", " "),
      AppLocalization.resetBalance: AppLocalization.resetBalance.replaceAll("_", " "),
      AppLocalization.familyMember: AppLocalization.familyMember.replaceAll("_", " "),
      AppLocalization.hintFamilyField: AppLocalization.hintFamilyField.replaceAll("_", " "),
      AppLocalization.hintLitrePriceField: AppLocalization.hintLitrePriceField.replaceAll("_", " "),
      AppLocalization.errorFamilyMember: AppLocalization.errorFamilyMember.replaceAll("_", " "),
      AppLocalization.errorLitrePerPrice: AppLocalization.errorLitrePerPrice.replaceAll("_", " "),
      AppLocalization.hintReset: AppLocalization.hintReset.replaceAll("_", " "),
      AppLocalization.confirm: AppLocalization.confirm.replaceAll("_", " "),
      AppLocalization.people: AppLocalization.people.replaceAll("_", " "),
      AppLocalization.peoples: AppLocalization.peoples.replaceAll("_", " "),
      AppLocalization.noticeFamilyCounter: AppLocalization.noticeFamilyCounter.replaceAll("_", " "),
      AppLocalization.noticeLitrePrice: AppLocalization.noticeLitrePrice.replaceAll("_", " "),
      AppLocalization.pricePerLitre: AppLocalization.pricePerLitre.replaceAll("_", " "),
      AppLocalization.noticeWaterAtmBalance: AppLocalization.noticeWaterAtmBalance.replaceAll("_", " "),
    },
    "bn": {
      AppLocalization.dailyAverageCost: "দৈনিক গড় খরচ",
      AppLocalization.lastAverageMonthlyCost: "সর্বশেষ মাসিক গড় খরচ",
      AppLocalization.dailyWaterIntake: "দৈনিক পানি গ্রহণ",
      AppLocalization.electricityMeter: "বিদ্যুৎ মিটার",
      AppLocalization.cylinderGas: "সিলিন্ডার গ্যাস",
      AppLocalization.waterPump: "ওয়াটার পাম্প",
      AppLocalization.drinkingWater: "ড্রিঙ্কিং ওয়াটার",
      AppLocalization.itMayContinueFor: "এটি চলতে পারে আরও",
      AppLocalization.days: "দিন",
      AppLocalization.day: "দিন",
      AppLocalization.tk: "৳",
      AppLocalization.settings: "সেটিংস",
      AppLocalization.dailyLog: "ডেইলি লগ",
      AppLocalization.switchLanguage: "ভাষা পরিবর্তন",
      AppLocalization.electricityLogs: "বিদ্যুতের লগ",
      AppLocalization.entryLog: "এন্ট্রি লগ",
      AppLocalization.hintElectricityField: "বিদ্যুৎ মিটারের ব্যালেন্স লিখুন*",
      AppLocalization.hintGasField: "সিলিন্ডার গ্যাসের দাম লিখুন*",
      AppLocalization.hintCalendarField: "তারিখ এবং সময় বাছুন",
      AppLocalization.edit: "এডিট করুন",
      AppLocalization.delete: "মুছে ফেলুন",
      AppLocalization.newFeature: "নতুন ফিচার",
      AppLocalization.comingSoon: "শীঘ্রই আসছে",
      AppLocalization.submit: "জমা করুন",
      AppLocalization.noDataFound: "কোন তথ্য পাওয়া যায়নি",
      AppLocalization.errorElectricityBalance: "বিদ্যুৎ ব্যালেন্স খালি রাখা যাবে না",
      AppLocalization.errorGasPrice: "গ্যাসের দাম খালি রাখা যাবে না",
      AppLocalization.defaultLanguage: "বাংলা",
      AppLocalization.errorWaterPumpAmount: "পানির পরিমাণ খালি রাখা যাবে না",
      AppLocalization.hintWaterAmountField: "পানির পরিমাণ লিখুন*",
      AppLocalization.hintWaterBalanceField: "পানির এটিএম ব্যালেন্স লিখুন*",
      AppLocalization.newBalance: "নতুন ব্যালেন্স",
      AppLocalization.errorWaterAtmBalance: "এটিএম ব্যালেন্স খালি রাখা যাবে না",
      AppLocalization.possibleWaterBalance: "সম্ভাব্য বর্তমান ব্যালেন্স",
      AppLocalization.rechargeWaterCard: "পানির নতুন ব্যালেন্স",
      AppLocalization.resetBalance: "ব্যালেন্স রিসেট",
      AppLocalization.familyMember: "পরিবারের সদস্য",
      AppLocalization.hintFamilyField: "সদস্য সংখ্যা লিখুন*",
      AppLocalization.errorFamilyMember: "সদস্য সংখ্যা খালি রাখা যাবে না",
      AppLocalization.hintReset: "আপনি কি নিশ্চিত? এই অপারেশনটি কার্ডের সমস্ত ব্যালেন্স লগ মুছে ফেলবে এবং ওয়াটার এটিএম ব্যালেন্স 0 তে রিসেট করবে",
      AppLocalization.confirm: "নিশ্চিত",
      AppLocalization.people: "জন",
      AppLocalization.peoples: "জন",
      AppLocalization.noticeFamilyCounter: "এই তথ্যটি দৈনিক পানি গ্রহণের গণনাতে ব্যবহৃত হবে",
      AppLocalization.pricePerLitre: "লিটার প্রতি মূল্য",
      AppLocalization.errorLitrePerPrice: "লিটার প্রতি মূল্য খালি রাখা যাবে না।",
      AppLocalization.hintLitrePriceField: "প্রতি লিটারের দাম লিখুন*",
      AppLocalization.noticeLitrePrice: "এই তথ্য পানির কার্ডের ব্যালেন্সের গণনাতে ব্যবহৃত হবে",
      AppLocalization.noticeWaterAtmBalance: "ব্যালেন্স পাওয়া যায়নি, দয়া করে সেটিংয়ে গিয়ে পানির এটিএম ব্যালেন্স যোগ করুন।",
    },
  };
}