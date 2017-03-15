//= require jquery
//= require jquery_ujs
//= require webpack-bundle
//= require turbolinks
//= require foundation
//= require jquery.dataTables.min
//= require dataTables.foundation.min
//= require Chart.bundle.min
//= require Chart.Custom
//= require prism

Chart.defaults.global.defaultFontFamily = "FreeSet, 'Helvetica Neue', Helvetica, Roboto, Arial, sans-serif;"

document.addEventListener("turbolinks:load", function() {
  var doc      = $(document),
      table    = doc.find('table'),
      dropDown = doc.find('.dropdown_profile');

  doc.foundation(); // init foundation

  Prism.highlightAll(); // init highlights

  table.each(function() { // init datatables
    $(this).dataTable({
      "bFilter": false,
      "bLengthChange": false,
      "bInfo": false,
      "bPaginate": true
    });
  });

  $('.inline-editable').on('change', function(e) {
    var form = $(this).closest('form');
    e.preventDefault();
    $.ajax(({
      type: "PUT",
      url: form.attr('action'),
      data: form.serialize()
    }));
  });

  Turbolinks.BrowserAdapter.prototype.showProgressBarAfterDelay = function() {
    return this.progressBarTimeout = setTimeout(this.showProgressBar, 0);
  }
});
