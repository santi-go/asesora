class SolicitudeShow{

  constructor(){
  }

  clickOnEditButton(){
      browser.waitForVisible('#edit-button', 2000)
      const data = $('#edit-button')
      data.click()
  }

  waitFor(field){
    browser.waitForVisible(field, 2000)
    browser.scroll(field)
  }
}

module.exports = SolicitudeShow
