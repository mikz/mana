class CardCollectionView extends Backbone.View

  constructor: (attrs) ->
    super(attrs)
    throw 'Missing model' unless @model

    clazz = @constructor.name.toLowerCase()
    @template = _.template($("##{clazz}-template").html())
    @el = $(@template(@model))

    @model.bind 'add', @render
    @model.bind 'remove', @render
    @model.bind 'refresh', @render

  _accept_unless_in: (card)  =>
    !@model.include(card.ob().model)

  dropped: (event,ui) =>
    card = ui.draggable.ob().model
    card.move_to(@model)
    card.save()

  toggle_visible: =>
    @visible = !@visible
    @render()

  render: =>
    console.info 'here'
    console.info @el

    if @visible
      console.info 'is visible'
      @el.fadeIn()
      @_render_if_visible()
    else
      @el.fadeOut()

    this
