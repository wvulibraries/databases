// Initialize Hiraku offcanvas navigation for admin panel.
// CRITICAL FIX: Manually add .js-hiraku-offcanvas-body-active to body after init.
// Without this, the CSS rule (body.js-hiraku-offcanvas-body-active .js-hiraku-offcanvas-sidebar-right)
// never matches and the nav renders as a normal block element at page top.

var hirakuInstance = null;
var menuOverlay = null;

// Create overlay element that covers full viewport when menu opens
function createMenuOverlay() {
  if (menuOverlay) return menuOverlay;
  
  menuOverlay = document.createElement('div');
  menuOverlay.className = 'menu-overlay';
  menuOverlay.style.cssText = [
    'display:none;',
    'position:fixed;',
    'top:0;',              // Fixed to html element — no transform context needed
    'left:0;',             // Full viewport coverage via position:fixed on <html>
    'width:100vw;',
    'height:100vh;',
    'z-index:100000;',
    'background:rgba(44,62,80,0.95);',
    'pointer-events:auto;'
  ].join('');
  
  document.documentElement.appendChild(menuOverlay);
  return menuOverlay;
}

// Show the overlay when menu opens
function showOverlay() {
  var overlay = createMenuOverlay();
  if (overlay) {
    overlay.style.display = 'block';
  }
}

// Hide the overlay when menu closes
function hideOverlay() {
  if (menuOverlay) {
    menuOverlay.style.display = 'none';
  }
}

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
    
    // Fix overlay to cover full viewport despite body transform
    var sideEl = document.querySelector('.offcanvas-left');
    if (sideEl) {
      // Listen for aria-hidden changes on the nav element
      var observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
          if (mutation.attributeName === 'aria-hidden') {
            var newVal = sideEl.getAttribute('aria-hidden');
            if (newVal === 'false') {
              showOverlay();
            } else {
              hideOverlay();
            }
          }
        });
      });
      
      observer.observe(sideEl, { attributes: true });
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
