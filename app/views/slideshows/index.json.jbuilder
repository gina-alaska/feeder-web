json.array!(@slideshows) do |slideshow|
  json.extract! slideshow, :id, :title, :uid
  json.url slideshow_url(slideshow, format: :json)
end
