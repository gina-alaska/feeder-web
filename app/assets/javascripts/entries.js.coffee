# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  $('.image-list').imagesLoaded().progress (instance, image) ->
    if image.isLoaded
      #success
      $(image.img).parent().removeClass('is-loading')
      if $(image.img).data('behavior') == 'zoom'
        $(image.img).parent().zoom({
          url: $(image.img).data('zoom-image')
        })
    else
      $(image.img).parent().removeClass('is-loading').addClass('is-broken')