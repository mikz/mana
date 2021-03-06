class Dropbox extends CardCollectionView

  @tagName: 'div'
  @className: 'box'

  constructor: (attrs) ->
    super(attrs)

    @visible = true
    @_enable_browsing()
    @box = @$('.box')
    @box.css('position','relative')
    @box.droppable
      accept: @_accept_unless_in
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

    # TODO - DRY - abstract overlay
    @box.mouseenter =>
      @$('.overlay').fadeIn()

    @box.mouseleave =>
      @$('.overlay').fadeOut()


  _enable_browsing: =>
    @browser = new CardBrowser({ model: @model, dropbox: this })
    @$('.browse-button').click =>
      @browser.toggle_visible()
      @toggle_visible()

  tappingAllowed: -> false

  _render_if_visible: =>
    @$('.count').text(@model.length)
    @model.each (card, i) =>
      # el = CardView.find_or_create(card).render().el
      el  = CardView.find_or_create(@model.at(@model.length - i - 1)).render().el
      # TODO: DRY and optimize
      el.detach()
      el.appendTo(@box)
      el.css('position','relative')
      el.offset({ top: @box.offset().top + 5, left: @box.offset().left + 5 })
      # el.offset({ top: 5, left: 5 })
