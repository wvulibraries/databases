// Fix offcanvas nav: bind to BOTH turbo:load (initial page load) AND turbo:render (subsequent Turbo navigations).
// turbo:render alone does NOT fire on the very first visit, so Hiraku never initializes.
// The guard prevents double-initialization when both events fire for the same page.
function initOffCanvas() {
  // Guard: prevent double-initialization
  if ($('#offCanvas').hasClass('js-hiraku-offcanvas-sidebar-right') || $('#offCanvas').hasClass('js-hiraku-offcanvas-sidebar-left')) {
    return;
  }
  new Hiraku(".offcanvas-left", {
    btn: "#offcanvas-btn-left",
    direction: "right", 
    closeBtn: '.close-button',
    width: '300px' 
  });
}

$( document ).on('turbo:load', initOffCanvas);
$( document ).on('turbo:render', initOffCanvas); 