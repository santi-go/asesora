require_relative './fixtures'

class SolicitudeBuilder
  def self.default
    new()
  end

  def initialize
    @solicitude = {
      applicantId: "",
      applicantName: Fixtures::APPLICANT_NAME,
      applicantSurname: Fixtures::APPLICANT_SURNAME,
      applicantEmail: Fixtures::APPLICANT_EMAIL,
      applicantPhonenumber: Fixtures::APPLICANT_PHONENUMBER,
      ccaa: Fixtures::APPLICANT_CCAA,
      text: Fixtures::TEXT,
      date: Fixtures::DATE,
      companyName: Fixtures::COMPANY_NAME,
      companyCif: Fixtures::COMPANY_CIF
    }
  end

  def with
    self
  end

  def text(value)
    @solicitude[:text] = value
    self
  end

  def company_name(value)
    @solicitude[:companyName] = value
    self
  end

  def date(value)
    @solicitude[:date] = value
    self
  end

  def creation_moment(value)
    @solicitude[:creation_moment] = value
    self
  end

  def build
    @solicitude
  end
end
