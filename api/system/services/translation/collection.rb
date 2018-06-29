module Translation
  class Collection
    DEFAULT_LOCALE = 'es'

    class << self
      def retrieve(locale)
        locale = DEFAULT_LOCALE unless Dictionary.has?(locale)

        Dictionary.retrieve(locale)
      end
    end

    class Dictionary
      class << self
        def has?(locale)
          dictionary.has_key?(locale)
        end

        def retrieve(locale)
          dictionary[locale]
        end

        private

        def dictionary
          {
            "es" => {
              "about": {
                "description": "Registro de asesoramientos técnicos en salud laboral"
              },

              "sidebar": {
                "solicitudeList": "Listado de solicitudes",
                "createSolicitude": "Nueva solicitud"
              },

              "solicitude": {
                "applicant": "Solicitante",
                "date": "Fecha",
                "applicantName": "Nombre",
                "applicantSurname": "Apellidos",
                "applicantEmail": "Correo Electrónico",
                "applicantPhonenumber": "Teléfono",
                "noContact": "Debes proporcionar al menos email o teléfono para guardar la solicitud",
                "text": "Texto",
                "noDate": "Si no indicas fecha de la solicitud, ésta se registrará con la fecha de hoy",
                "incompleteCompanyIdentity": "Debes proporcionar un CIF válido, ejemplo: '12345678Z'",
                "noCompanyName": "Debes proporcionar un nombre de empresa",
                "companyInfo": "Si quieres guardar la empresa debes proporcionar su nombre y su cif",
                "company": "Empresa",
                "companyName": "Nombre empresa",
                "companyCif": "CIF",
                "companyEmployees": "Número trabajadoras y trabajadores",
                "companyCnae": "CNAE",
                "addSubject": "Añadir Caso",
                "submit": "Solicitar",
                "subjectsList": "Listado de casos",
                "submitting": "Solicitando",
                "editionsubmit": "Guardar cambios",
                "editionsubmitting": "Guardando",
                "editiondiscard": "Descartar",
                "edited": "Todo Ok! Guardado!",
                "editCompany": "Modificar Empresa",
                "editingCompany": "Las modificaciones que introduzcas afectarán a todos los casos asociados a esta empresa",
                "alertBackgroundDanger": "Lo sentimos, ha habido un error",
                "suggestions": "Sugerencias",
                "deleteSolicitude": "Eliminar solicitud",
                "errorPhone": "El teléfono debe tener nueve números para ser válido",
                "errorEmail": "El email no tiene un formato correcto, ejemplo: 'nombre@gmail.es'",
                "sent": "Todo Ok! Enviado!",
                "addedEmployeesValueMessage": "Se ha agregado información actualizada de número de empleados a la empresa",
                "addedNameValueMessage": "Se ha agregado información actualizada del nombre de la empresa",
                "addValue": "Agregar valor",
                "proposals": "Propuestas de actuación",
                "analysis": "Análisis de la solicitud",
                "topics": "Temas del caso",
                "submittoSubject": "Solicitar y añadir caso",
                "editionsubmittoSubject": "Guardar cambios y añadir caso",
                "notApply": "N/A",
                "subject": "Caso"
              },

              "solicitudes-list": {
                "listTitle": "Tus asesoramientos",
                "code": "Código de registro",
                "date": "Fecha de solicitud",
                "applicant": "Nombre completo del solicitante",
                "company": "Nombre de empresa",
                "topics": "Temas del caso",
                "notApply": "n/a",
                "edit": "Editar",
                "show": "Mostrar"
              },

              "show-solicitude": {
                "summary": "Datos de la solicitud",
                "edit": "Editar",
                "addSubject": "Añadir Caso",
                "date": "Fecha",
                "text": "Texto",
                "applicant": "Solicitante",
                "applicantName": "Nombre",
                "applicantSurname": "Apellidos",
                "applicantEmail": "Correo Electrónico",
                "applicantPhonenumber": "Teléfono",
                "company": "Empresa",
                "companyName": "Nombre empresa",
                "companyCif": "CIF",
                "companyEmployees": "Número trabajadoras y trabajadores",
                "companyCnae": "CNAE",
                "proposals": "Propuestas de actuación",
                "analysis": "Análisis de la solicitud",
                "topics": "Temas del caso",
                "subjectsList": "Listado de casos",
                "notApply": "N/A",
                "subject": "Caso"
              },

              "subjects": {
                "proposals": "Propuestas de actuación",
                "analysis": "Análisis de la solicitud",
                "subjectsData": "Datos del caso",
                "edit": "Editar",
                "addSubject": "Añadir caso",
                "createSubject": "Crear asesoramiento",
                "topics": "Temas del caso"
              }
            },

            "en" => {
              "about": {
                "description": "asesora application"
              }
            }
          }
        end
      end
    end
  end
end
