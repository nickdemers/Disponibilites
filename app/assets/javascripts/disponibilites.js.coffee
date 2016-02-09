# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#date_debut').datepicker({
  format: 'yyyy-mm-dd',
  autoclose: true,
  language: 'fr'
})
  .on 'changeDate', (ev) ->
    $('#date_debut').datepicker('hide')

$('#date_fin').datepicker({
  format: 'yyyy-mm-dd',
  autoclose: true,
  language: 'fr'
})
  .on 'changeDate', (ev) ->
    $('#date_fin').datepicker('hide')

@display_clock = (clock_id, date_limit) ->
  $(clock_id).countdown(date_limit)
    .on('update.countdown', (event) ->
      format = '%H:%M:%S'
      if(event.offset.days > 0)
        format = '%-d day%!d ' + format
      if(event.offset.weeks > 0)
        format = '%-w week%!w ' + format
      $(this).html(event.strftime(format))
    )
    .on('finish.countdown', (event) ->
      if (date_limit != "")
        $(this).html('Cette offre de remplacement est expirée.').parent().addClass('disabled')
      else
        $(this).html('').parent().addClass('disabled')
    )