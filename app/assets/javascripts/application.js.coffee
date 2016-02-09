
#= require flatty/jquery/jquery.min
#= require flatty/jquery/jquery.mobile.custom.min
#= require flatty/jquery/jquery-migrate.min
#= require flatty/jquery/jquery-ui.min
#= require flatty/bootstrap/bootstrap.min
#= require flatty/plugins/plugins
#= require flatty/theme

#= require jquery_ujs
#= require plugins/moment/moment
#= require plugins/daterangepicker/daterangepicker
#= require plugins/datepicker/bootstrap-datepicker
#= require plugins/countdown/jquery.countdown
#= #require twitter/bootstrap
#= #require moment
#= #require daterangepicker
#= #require_tree .

#$ ->
#  $('.input-group.date').datepicker({
#      autoclose: true,
#      language: 'fr',
#      format: "yyyy-mm-dd"
#  })

#$.fn.datepicker.dates['fr'] = {
#    days: ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"],
#    daysShort: ["Dim", "Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Dim"],
#    daysMin: ["D", "L", "Ma", "Me", "J", "V", "S", "D"],
#    months: ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre",
#        "Décembre"],
#    monthsShort: ["Jan", "Fev", "Mar", "Avr", "Mai", "Jui", "Jul", "Aou", "Sep", "Oct", "Nov", "Dec"],
#    today: "Aujourd'hui"
#}