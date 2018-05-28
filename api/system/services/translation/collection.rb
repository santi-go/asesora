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
                "name": "Nombre",
                "surname": "Apellidos",
                "email": "Correo Electrónico",
                "phonenumber": "Teléfono",
                "noContact": "Si necesitas contactar más adelante con el o la solicitante, deberías poner su email o teléfono",
                "text": "Texto",
                "noDate": "Si no indicas fecha de la solicitud, ésta se registrará con la fecha de hoy",
                "incompleteCompanyIdentity": "No has proporcionado suficiente información de la empresa",
                "company": "Empresa",
                "companyName": "Nombre empresa",
                "companyCif": "CIF",
                "companyEmployees": "Número trabajadoras y trabajadores",
                "companyCnae": "CNAE",
                "submit": "Solicitar",
                "submitting": "Solicitando",
                "editionsubmit": "Guardar cambios",
                "editionsubmitting": "Guardando",
                "editiondiscard": "Descartar",
                "edited": "Todo Ok! Guardado!",
                "alertBackgroundDanger": "Lo sentimos, ha habido un error",
                "suggestions": "Sugerencias",
                "sent": "Todo Ok! Enviado!",
                "editCompany": "Modificar Empresa"
              },

              "solicitudes-list": {
                "listTitle": "Tus asesoramientos",
                "code": "Código de registro",
                "date": "Fecha de solicitud",
                "applicant": "Nombre completo del solicitante",
                "company": "Nombre de empresa",
                "topics": "Temas del caso",
                "notApply": "n/a"
              },

              "solicitudes-edition": {
                "applicant": "Solicitante",
                "name": "Nombre",
                "surname": "Apellidos",
                "contact": "Contacto",
                "email": "Correo Electrónico",
                "phonenumber": "Teléfono",
                "noContact": "Si necesitas contactar más adelante con el o la solicitante, deberías poner su email o teléfono",
                "date": "Fecha",
                "text": "Texto",
                "noDate": "Si no indicas fecha de la solicitud, ésta se registrará con la fecha de hoy",
                "incompleteCompanyIdentity": "No has proporcionado suficiente información de la empresa",
                "company": "Empresa",
                "companyName": "Nombre empresa",
                "companyCif": "CIF",
                "companyEmployees": "Número trabajadoras y trabajadores",
                "companyCnae": "CNAE",
                "submit": "Guardar cambios",
                "submitting": "Guardando",
                "discard": "Descartar",
                "discarding": "Descartando",
                "edited": "Todo Ok! Guardado!",
                "alertBackgroundDanger": "Lo sentimos, ha habido un error"
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
