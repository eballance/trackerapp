class @EntryForm

  constructor: (@form, @locale) ->
    @initDatepicker()

  initDatepicker: ->
    configuration = {
      en: {
        formatSubmit: 'dd/mm/yyyy',
        today: false,
        clear: false
      },
      cs: {
        formatSubmit: 'dd/mm/yyyy',
        today: false,
        clear: false,
        monthsFull: [ 'leden', 'únor', 'březen', 'duben', 'květen', 'červen', 'červenec', 'srpen', 'září', 'říjen', 'listopad', 'prosinec' ],
        monthsShort: [ 'led', 'úno', 'bře', 'dub', 'kvě', 'čer', 'čvc', 'srp', 'zář', 'říj', 'lis', 'pro' ],
        weekdaysFull: [ 'neděle', 'pondělí', 'úterý', 'středa', 'čtvrtek', 'pátek', 'sobota' ],
        weekdaysShort: [ 'ne', 'po', 'út', 'st', 'čt', 'pá', 'so' ]
      }
    }

    picker = @form.find('.datepicker').pickadate(configuration[@locale]).pickadate('picker')
    $(picker._hidden).attr('name', 'entry_form[date]').attr('id', 'entry_form_date')
