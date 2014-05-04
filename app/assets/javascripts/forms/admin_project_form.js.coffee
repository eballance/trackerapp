class @AdminProjectForm

  constructor: (@form) ->
    @initSelect2()

  initSelect2: ->
    input = @form.find("#project_user_ids")
    input.select2()
