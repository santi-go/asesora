
export let SolicitudeModel = {
  labels: {
    "analysis": "",
    "applicant": "",
    "date": "",
    "applicantEmail": "",
    "applicantPhonenumber": "",
    "applicantName": "",
    "applicantSurname": "",
    "text": "",
    "noDate": "",
    "addSubject": "",
    "company": "",
    "companyName": "",
    "companyCif": "",
    "companyEmployees": "",
    "companyCnae": "",
    "noContact": "",
    "incompleteCompanyIdentity": "",
    "noCompanyName": "",
    "suggestions" : "",
    "submit" : "",
    "editCompany":"",
    "editingCompany": "",
    "submitting" : "",
    "editiondiscard" : "",
    "editionsubmit" : "",
    "editionsubmitting" : "",
    "deleteSolicitude" : "",
    "errorPhone": "",
    "errorEmail": "",
    "proposals": "",
    "topics": "",
    "sent": "",
    "subjectsList": "",
    "addValue": "",
    "addedEmployeesValueMessage": "",
    "addedNameValueMessage": "",
    "companyInfo": "",
    "submittoSubject": "",
    "editionsubmittoSubject": "",
    "notApply": "",
    "subject": "",
    "modifySubject": "",
    "subjectModified": "",
    "modify": "",
    "ccaa": "",
    "personalData": "",
    "contactData": "",
    "solicitudeData": "",
    "solicitude": "",
    "identification": "",
    "information": "",
    "description": "",
    "placeholderdescription": "",
    "comments": "",
    "reason": "",
    "closeCounseling": "",
    "closedSubject": "",
    "source": "",
    "discard": ""
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
    "reason": "",
    "closed": "",
    "source": []
  },
  sourceCatalog: [],
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
  reasonsCatalog: [],
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
