class PatientInfo {
  int? checkupFor;
  int? patientGender;
  int? patientAge;
  int? isOverweight;
  int? isHypertension;
  int? isSmoker;
  int? isInjury;
  List<String>? selectedSymptomsList = [];
  List<String>? checkedSymptomsList = [];

  PatientInfo({
    this.checkupFor,
    this.patientGender,
    this.patientAge,
    this.isOverweight,
    this.isHypertension,
    this.isSmoker,
    this.isInjury,
    this.selectedSymptomsList,
    this.checkedSymptomsList,
  });
}
