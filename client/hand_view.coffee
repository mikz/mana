class HandView extends FloatingBrowser

  @tagName: 'div'
  @className: 'hand'

  constructor: (attrs) ->
    super(attrs)

    if @model.user.local
      @visible = true
      Controls.current.bind 'key:spacebar', @toggle_visible
      $('#battlefield').click _.wrap( @toggle_visible, _.preventer)
      $('#battlefield').bind('contextmenu', _.wrap( @toggle_visible, _.preventer))
      @el.droppable('option','drop', @_dropped_and_turned)

  # TODO: DRY
  _dropped_and_turned: (event, ui) =>
    card = ui.draggable.ob().model
    card.move_to(@model)
    card.toggle_covered(false, { save: false })
    card.save()

  render: =>
    if @visible
      @el.fadeIn()
    else
      @el.fadeOut()

    @_render_cards()
    this


  _render_cards: =>
    views = @model.map (card) -> CardView.find_or_create(card)

    padding = 10
    @el.css('width', (padding + CARD_W) * @model.length + 2*padding)
    _.each views, (card, i) =>
      card.el.detach()
      card.el.appendTo(@el)
      card.el.offset
       top: @el.offset().top + 40,
       left: padding + @el.offset().left + i * (padding + CARD_W),
