$(document).on 'changeDate', '[date-click="reload-entries"]', (e) ->
  console.log arguments
  
  path = top.location.path
  console.log path
  
  # Turbolinks.visit(path + '?date=#{}')
  
$(document).on 'ready page:load', ->
  $('[data-behavior="tooltip"]').tooltip()
  datepicker = $('[data-behavior="calendar"]').datepicker({
    format: 'yyyy-mm-dd'
  })
  
  datepicker.on 'changeDate', (e) ->
    date = moment(e.date)
    path = top.location.pathname
    Turbolinks.visit(path + "?date=#{date.format('YYYY-MM-DD')}")
