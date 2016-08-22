//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require foundation
//= require jquery.dataTables.min
//= require dataTables.foundation.min
//= require_tree .

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
