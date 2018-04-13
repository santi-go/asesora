module Translation
  class Collection
    DEFAULT_LOCALE = 'es'
    @collection = {
        "es" => {
            "description": "Registro de asesoramientos tecnicos en salud laboral",
            "applicant": "Solicitante",
            "date": "Fecha",
            "text": "Texto",
            "noDate": "Si no indicas fecha de la solicitud, ésta se registrará con la fecha de hoy"
        },
        "en" => {
            "description": "asesora application"
        }
    }

    class << self
      def retrieve(locale)
        locale = DEFAULT_LOCALE unless @collection.has_key?(locale)

        @collection[locale]
      end
    end
  end
end
