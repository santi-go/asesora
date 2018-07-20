
export let ShowSolicitudeModel = {
    labels: {
      "proposals": "",
      "analysis": "",
      "topics": "",
      "edit": "",
      "addSubject": "",
      "subjectsData": "",
      "summary": "",
      "applicant": "",
      "company": "",
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
      "subjectsList": "",
      "notApply": "",
      "subject": "",
      "description": "",
      "placeholderdescription": "",
      "comments": "",
      "reason": "",
      "source": "",
      "deleteSubject": ""
    },
    values: {
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
      "subjects": "",
      "reason": "",
      "source": ""
    },
    buttonsPresent: true,
    hasSubjects: false,
    setValues:function(key, value) {
      this.values[key] = value
    },
    translate:function(key,value) {
      this.labels[key] = value
    }
  }
