
export let SolicitudesListModel = {
  labels: { "code": "",
            "date": "",
            "applicant": "",
            "company": "",
            "topics": "",
            "listTitle": "",
            "notApply": "",
            "edit": "",
            "show": ""
          },
  solicitudes: [
    {
      creation_moment:"",
      date:""
    },
  ],
  fullfilled: false,
  translate:function(key,value) {
    this.labels[key] = value
  }
}
