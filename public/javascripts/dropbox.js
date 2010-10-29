Dropbox = function(element) {
  this.element = element;
  Utils.setObjectToDom(this.element, this);
  this.initDOM();
}

Dropbox.initialize = function() {
    $('#graveyard, #exile').each(function(i) {
        new Dropbox($(this));
    });
}

Dropbox.prototype.dropped = function(card) {
    card.element.detach();
    card.element.appendTo(this.element);
}

Dropbox.prototype.initDOM = function() {

    this.element.droppable({
      hoverClass: 'selected',
      drop: function(event,ui) {
          box = Utils.getObjectFromDom(this);
          card = Utils.getObjectFromDom(ui.draggable);
          box.dropped(card);
      }
    });
}