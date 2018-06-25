class SolicitudeBuilder
  def self.default
    new()
  end

  def initialize
    @solicitude = {
      applicantId: "",
      applicantName: AsesoraWithFixtures::APPLICANT_NAME,
      applicantSurname: AsesoraWithFixtures::APPLICANT_SURNAME,
      applicantEmail: AsesoraWithFixtures::APPLICANT_EMAIL,
      applicantPhonenumber: AsesoraWithFixtures::APPLICANT_PHONENUMBER,
      text: AsesoraWithFixtures::TEXT,
      date: AsesoraWithFixtures::DATE,
      companyName: AsesoraWithFixtures::COMPANY_NAME,
      companyCif: AsesoraWithFixtures::COMPANY_CIF
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
