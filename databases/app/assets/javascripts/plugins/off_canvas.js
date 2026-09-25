$( document ).on('turbo:render', function() {
  // Guard: prevent double-initialization (Turbo fires multiple events)
  if ($('#offCanvas').hasClass('js-hiraku-offcanvas-sidebar-right') || $('#offCanvas').hasClass('js-hiraku-offcanvas-sidebar-left')) {
    return;
  }
  
  new Hiraku(".offcanvas-left", {
    btn: "#offcanvas-btn-left",
    direction: "right", 
    closeBtn: '.close-button',
    width: '300px' 
  });
}); 