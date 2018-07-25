
export let SolicitudesListModel = {
  labels: { "code": "",
            "date": "",
            "applicant": "",
            "company": "",
            "topics": "",
            "listTitle": "",
            "notApply": "",
            "edit": "",
            "show": "",
            "subjects": "",
            "feprl": ""
          },
  solicitudes: [
    {
      creation_moment: "",
      date: "",
      subjects: ""
    },
  ],
  fullfilled: false,
  translate:function(key,value) {
    this.labels[key] = value
  }
}
