Utils = function() {}

function switch_parent(box, parent, prepend) {
  var old = box.offset();
  box.detach();
//  prepend ? box.prependTo(parent) : box.appendTo(parent);
  box.prependTo(parent);
  box.offset(old);
}


Utils.setObjectToDom = function(element, data) {
  $(element).data('game-object', data);
  data.element = element;
  return data;
}

Utils.getObjectFromDom = function(element) {
    return $(element).data('game-object');
}