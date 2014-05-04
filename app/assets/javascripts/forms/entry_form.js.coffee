class @EntryForm

  constructor: (@form, @locale) ->
    @initDatepicker()
    @initValidations()

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

  initValidations: ->
    original_border_color = $("#entry_form_time_spent").css("border-color")
    $('input[type=submit]').attr('disabled', true)
    $("#entry_form_time_spent_error").hide()
    $("#entry_form_time_spent").blur ->
      if not @value
        $("#entry_form_time_spent").css("border-color", "#fc0000")
        $('input[type=submit]').attr('disabled', true)
        $("#entry_form_time_spent_error").show()
        $("#entry_form_time_spent_error").text("Time spent cannot be empty.")
      else if /^\d+\:\d\d$/.test(@value) or \
          /^\d+\.\d+$/.test(@value) or \
          /^\d+$/.test(@value) or \
          /^\d+\s*h$/.test(@value) or \
          /^\d+\.\d+\s*h$/.test(@value)
        $("#entry_form_time_spent").css("border-color", original_border_color)
        $('input[type=submit]').attr('disabled', false)
        $("#entry_form_time_spent_error").hide()
      else
        $("#entry_form_time_spent").css("border-color", "#fc0000")
        $('input[type=submit]').attr('disabled', true)
        $("#entry_form_time_spent_error").show()
        $("#entry_form_time_spent_error").text("Invalid format of time spent, use following '1:30, 1.5, 90, 1h'")
