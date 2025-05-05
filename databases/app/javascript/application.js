// Add this at the bottom of the file
document.addEventListener('DOMContentLoaded', function() {
  // Fix admin panel buttons text
  const adminButtons = document.querySelectorAll('.button.admin-panel');
  adminButtons.forEach(function(button) {
    button.style.color = 'white';
    button.style.backgroundColor = '#0049AC';
    button.style.borderColor = '#0049AC';
    button.style.textShadow = 'none';
    button.style.boxShadow = 'none';
    button.style.opacity = '1';
    
    const spans = button.querySelectorAll('span');
    spans.forEach(function(span) {
      span.style.color = 'white';
      span.style.textShadow = 'none';
      span.style.opacity = '1';
    });
  });
  
  // Fix signout buttons
  const signoutButtons = document.querySelectorAll('.button.signout');
  signoutButtons.forEach(function(button) {
    button.style.color = 'black';
    button.style.backgroundColor = '#EAAA00';
    button.style.borderColor = '#EAAA00';
    button.style.textShadow = 'none';
    
    const spans = button.querySelectorAll('span');
    spans.forEach(function(span) {
      span.style.color = 'black';
    });
  });
  
  // Fix header list layout
  const headerList = document.querySelector('.wvu-header-list');
  if (headerList && window.innerWidth >= 768) {
    headerList.style.float = 'right';
    headerList.style.textAlign = 'right';
    
    const ul = headerList.querySelector('ul');
    if (ul) ul.style.float = 'right';
  }
});