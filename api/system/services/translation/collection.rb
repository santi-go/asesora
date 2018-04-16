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
                "description": "Registro de asesoramientos tecnicos en salud laboral",
                "applicant": "Solicitante",
                "date": "Fecha",
                "text": "Texto",
                "noDate": "Si no indicas fecha de la solicitud, ésta se registrará con la fecha de hoy",
                "submit": "Solicitar",
                "submitting": "Solicitando"
            },
            "en" => {
                "description": "asesora application"
            }
          }
        end
      end
    end
  end
end
