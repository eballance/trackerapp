class @EntriesForm

  constructor: (@form) ->
    @projectSelect = @form.find("#project_id")
    @initSubmitOnChange()

  initSubmitOnChange: ->
    @form.find('select,input').change ->
      @form.submit()