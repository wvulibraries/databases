// Initialize Hiraku offcanvas navigation for admin panel.
// CRITICAL FIX: Manually add .js-hiraku-offcanvas-body-active to body after init.
// Without this, the CSS rule (body.js-hiraku-offcanvas-body-active .js-hiraku-offcanvas-sidebar-right)
// never matches and the nav renders as a normal block element at page top.

var hirakuInstance = null;

function initHirakuOffCanvas() {
  if (hirakuInstance) return; // Already initialized
  
  var sideEl = document.querySelector('.offcanvas-left');
  var btnEl = document.querySelector('#offcanvas-btn-left');
  
  if (!sideEl || !btnEl) return;
  if (typeof Hiraku === 'undefined') return;
  
  try {
    hirakuInstance = new Hiraku(".offcanvas-left", {
      btn: "#offcanvas-btn-left",
      direction: "right", 
      closeBtn: '.close-button',
      width: '300px' 
    });
    
    // CRITICAL FIX: Manually add body-active class so nav is hidden off-screen.
    if (document.body && !document.body.classList.contains('js-hiraku-offcanvas-body-active')) {
      document.body.classList.add('js-hiraku-offcanvas-body-active');
    }
  } catch(err) {
    console.error('Hiraku offcanvas init error:', err);
  }
}

// For initial page load (before Turbo takes over)
document.addEventListener('DOMContentLoaded', initHirakuOffCanvas);

// For subsequent Turbo navigations
$( document ).on('turbo:load', function() {
  if (!hirakuInstance) initHirakuOffCanvas();
});

$( document ).on('turbo:render', function() {
  var sideEl = document.querySelector('.offcanvas-left');
  if (!sideEl || sideEl.classList.contains('js-hiraku-offcanvas-sidebar-right')) return;
  if (!hirakuInstance) initHirakuOffCanvas();
});
