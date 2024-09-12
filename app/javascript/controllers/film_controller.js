document.addEventListener('turbo:before-fetch-request', function() {
  document.getElementById('loading-spinner').style.display = 'block'; // Show spinner
});

document.addEventListener('turbo:frame-load', function() {
  document.getElementById('loading-spinner').style.display = 'none'; // Hide spinner once content is loaded
});
