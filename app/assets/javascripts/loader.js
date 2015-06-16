var app = {};

$(document).ready(function () {

  /* allow additional options for datepicker, based on:
  / http://stackoverflow.com/questions/8308008/jquery-datepicker-override-options-from-data-attribute
  */
  $(".datepicker").each(function() {
    //standard options
    var options = { dateFormat: "dd.mm.yy"};
    //additional options
    var additionalOptions = $(this).data("datepicker");
    //merge the additional options into the standard options and override defaults
    jQuery.extend(options, additionalOptions);

    $(this).datepicker(options);
  });
});
