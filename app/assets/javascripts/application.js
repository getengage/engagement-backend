//= require jquery
//= require jquery_ujs
//= require webpack-bundle
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

  $('.dropdown_profile').on('show.zf.dropdownmenu', function() {
    var dropdown = $(this).find('.is-dropdown-submenu');

    if (!dropdown.hasClass('js-dropdown-animated')) {
      dropdown.css('display', 'inherit');
      dropdown.fadeIn({queue: false, duration: 'fast'});
      dropdown.animate({ "top": "+=30" }, 250 );
      dropdown.addClass('js-dropdown-animated');
    }
  });

  $('.dropdown_profile').on('hide.zf.dropdownmenu', function() {
    var dropdown = $(this).find('.is-dropdown-submenu');
    dropdown.fadeOut({queue: false, duration: 'fast'});
    dropdown.animate({ "top": "-=30" }, 250 );
    dropdown.removeClass('js-dropdown-animated');
  });

  Turbolinks.BrowserAdapter.prototype.showProgressBarAfterDelay = function() {
    return this.progressBarTimeout = setTimeout(this.showProgressBar, 0);
  }
});
