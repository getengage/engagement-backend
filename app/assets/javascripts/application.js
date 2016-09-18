  // DO NOT REQUIRE jQuery or jQuery-ujs in this file!
// DO NOT REQUIRE TREE!

// CRITICAL that vendor-bundle must be BEFORE bootstrap-sprockets and turbolinks
// since it is exposing jQuery and jQuery-ujs

//= require vendor-bundle
//= require app-bundle
//= require turbolinks
//= require foundation
//= require jquery.dataTables.min
//= require dataTables.foundation.min
//= require Chart.bundle.min

document.addEventListener("turbolinks:load", function() {
  $(document).foundation();

  $('table').each(function() {
    $(this).dataTable({
      "bFilter": false,
      "bLengthChange": false,
      "bInfo": false,
      "bPaginate": true
    });
  });
});

Turbolinks.BrowserAdapter.prototype.showProgressBarAfterDelay = function() {
  return this.progressBarTimeout = setTimeout(this.showProgressBar, 0);
};