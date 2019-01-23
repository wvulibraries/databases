$( document ).on('turbolinks:load', function() {
  new Hiraku(".offcanvas-left", {
    btn: "#offcanvas-btn-left",
    direction: "left", 
    closeBtn: '.close-button',
    width: '300px' 
  });
}); 