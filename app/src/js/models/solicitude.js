
export let SolicitudeModel = {
  labels: {
    "analysis": "xxxxxx",
    "applicant": "XXXXXXXX",
    "date": "XXXXX",
    "applicantEmail": "XXX",
    "applicantPhonenumber": "XXXXXXXXX",
    "applicantName": "XXXX",
    "applicantSurname": "XXXXXXXXX",
    "text": "XXXXX",
    "noDate": "XXXXX",
    "addSubject": "XXXXXX",
    "company": "XXXXXXX",
    "companyName": "XXXXXXXX",
    "companyCif": "XXXXXX",
    "companyEmployees": "XXXXXX",
    "companyCnae": "XXXXXXXX",
    "noContact": "XXXXX",
    "incompleteCompanyIdentity": "XXXXXXX",
    "noCompanyName": "xxxxxxxx",
    "suggestions" : "xxxxxx",
    "submit" : "xxxxxxxxxx",
    "editCompany":"xxxxxxxxxxx",
    "editingCompany": "xxxxxxxxxxxxxx",
    "submitting" : "xxxxxxxxxx",
    "editiondiscard" : "xxxxxxxxxx",
    "editionsubmit" : "xxxxxx",
    "editionsubmitting" : "xxxxxx",
    "deleteSolicitude" : "XXXXX",
    "errorPhone": "xxxxxxxx",
    "errorEmail": "xxxxxxx",
    "proposals": "xxxxx",
    "topics": "xxxxxxx",
    "sent": "XXXX",
    "subjectsList": "xxxxxxx",
    "addValue": "xxxxx",
    "addedEmployeesValueMessage": "xxxx",
    "addedNameValueMessage": "xxxx",
    "companyInfo": "xxxxxxx",
    "submittoSubject": "xxxxxxx",
    "editionsubmittoSubject": "xxxxxxx",
    "notApply": "xxxx",
    "subject": "xxxxx",
    "modifySubject": "xxxxx",
    "subjectModified": "xxxxx",
    "modify": "xxxxx",
    "ccaa": "xxxxx",
    "personalData": "xxxxxxx",
    "contactData": "xxxxxxx",
    "solicitudeData": "xxxxxxx",
    "solicitude": "xxxxxxx",
    "identification": "xxxxxxx",
    "information": "xxxxxxx",
    "description": "xxxxxxxxx",
    "placeholderdescription": "xxxxxxxxx",
    "comments": "xxxxxxxx",
    "closeCounseling": "xxxxx"
  },
  values: {
    "text": "",
    "text": "",
    "date": "",
    "id": "",
    "applicantName": "",
    "applicantSurname": "",
    "applicantEmail": "",
    "applicantPhonenumber": "",
    "applicantId": "",
    "applicantCcaa": "",
    "companyName": "",
    "companyCif": "",
    "companyEmployees": "",
    "companyCnae": "",
    "suggestions" : "",
    "subjects": [],
    "proposals": [],
    "analysis": "",
    "selectedTopics": [],
    "subjectId": "",
    "description": "",
    "comments": "",
    "reasons": "",
    "closing_moment": ""
  },
  ccaaCatalog: [],
  suggestedCompanies: [],
  suggestedApplicants: [],
  fullfilled: false,
  fullfilledToAddSubject: false,
  isValidCif: true,
  cnaeCatalog:[],
  isValidCompanyIdentity: true,
  isValidCompanyName: true,
  isValidContact: true,
  submittable: false,
  showAlert: true,
  showUpdatedEmployeesValueMessage: false,
  showUpdatedNameValueMessage: false,
  editionmode: false,
  editCompany: false,
  showEditCompanyButton: false,
  saveCompany: false,
  isValidPhone: true,
  isValidEmail: true,
  topicsCatalog: [],
  proposalsCatalog: [],
  editionSubject: false,
  modifiedSubjectId: 0,
  translate:function(key,value) {
    this.labels[key] = value
  },
  setValues:function(key, value) {
    this.values[key] = value
  },
  cloneValues:function(){
    let clone = Object.assign({}, this.values)
    return clone
  }
}
