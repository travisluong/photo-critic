class PhotoCritic.Routers.PhotosRouter extends Backbone.Router
  initialize: (options) ->
    @photos = new PhotoCritic.Collections.PhotosCollection()
    @navView = new PhotoCritic.Views.Home.NavView()
    $("#photo-critic-nav").html(@navView.render().el)
    # @photos.reset options.photos

  routes:
    "home"     : "home"
    "photos/new"      : "newPhoto"
    "photos/index"    : "indexPhoto"
    "photos/:id/edit" : "editPhoto"
    "photos/:id"      : "showPhoto"
    "photos"        : "indexPhoto"
    ".*"                : "home"

  home: ->
    @view = new PhotoCritic.Views.Home.Index()
    $("#photo-critic-app").html(@view.render().el)

  newPhoto: ->
    @view = new PhotoCritic.Views.Photos.NewView(collection: @photos)
    $("#photo-critic-app").html(@view.render().el)

  indexPhoto: ->
    @photos.reset()
    @photos.fetch()
    @view = new PhotoCritic.Views.Photos.IndexView(photos: @photos)
    $("#photo-critic-app").html(@view.render().el)

  showPhoto: (id) ->
    photo = new PhotoCritic.Models.Photo()
    photo.id = id
    photo.url = ->
      '/photos/' + id
    photo.fetch({success: (model, response, options) ->
      # photo = @photos.get(id)
      @view = new PhotoCritic.Views.Photos.ShowView(model: photo)
      $("#photo-critic-app").html(@view.render().el)
    })

  editPhoto: (id) ->
    photo = new PhotoCritic.Models.Photo()
    photo.id = id
    photo.url = ->
      '/photos/' + id
    photo.fetch({success: (model, response, options) ->
      # photo = @photos.get(id)
      @view = new PhotoCritic.Views.Photos.EditView(model: photo)
      $("#photo-critic-app").html(@view.render().el)
    })
