$(document).on('turbolinks:load', function() {
  $('#micropost_picture').bind('change', function() {
  var size_in_megabytes = this.files[0].size/1024/1024;
  var a = $('#btn_upload).data('picture')
    if (size_in_megabytes > a) {
      alert(I18n.t("picture.alert.error_image_upload_msg"));
    }
  });
});
