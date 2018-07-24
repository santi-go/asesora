
export let SubjectsModel = {
  labels: {
    "proposals": "",
    "analysis": "",
    "edit": "",
    "addSubject": "",
    "createSubject": "",
    "subjectsData": "",
    "subjectsList": "",
    "applicant": "",
    "company": "",
    "topics": "",
    "notApply": "",
    "placeholderAnalysis": "",
    "max200Words": "",
    "discardButtonSubject": "",
    "applicantName": "",
    "applicantSurname": "",
    "applicantCcaa": "",
    "applicantEmail": "",
    "applicantPhonenumber": "",
    "date": "",
    "text": "",
    "companyName": "",
    "companyCif": "",
    "companyEmployees": "",
    "companyCnae": "",
    "subject": "",
    "description": "",
    "placeholderdescription": "",
    "comments": "",
    "reason": "",
    "closeCounseling": "",
    "source": "",
    "discard": "",
    "deleteSubject": "",
    "required": "",
    "notJustifiable": ""
  },
  values: {
    "solicitudeId": "",
    "proposals": [],
    "analysis": "",
    "subjectId":"",
    "topics": "",
    "selectedTopics": [],
    "id": "",
    "applicantName": "",
    "applicantSurname": "",
    "applicantCcaa": "",
    "applicantEmail": "",
    "applicantPhonenumber": "",
    "date": "",
    "text": "",
    "companyName": "",
    "companyCif": "",
    "companyEmployees": "",
    "companyCnae": "",
    "subjects": [],
    "description": "",
    "comments": "",
    "reason": "",
    "closed": "",
    "source": ""
  },
  submittable: false,
  topicsCatalog: [],
  reasonsCatalog: [],
  proposalsCatalog: [],
  origin: "none",
  warningSubject: true,
  setValues:function(key, value) {
    this.values[key] = value
  },
  translate:function(key,value) {
    this.labels[key] = value
  }
}
