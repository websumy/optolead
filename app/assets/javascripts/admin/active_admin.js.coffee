#= require active_admin/base
#= require tinymce

tinyMCE.init({
  selector: 'textarea.editor',
  toolbar: 'bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image media | forecolor backcolor | fullscreen',
  plugins: 'table fullscreen advlist autolink lists link image charmap hr anchor searchreplace visualblocks visualchars code fullscreen insertdatetime media nonbreaking table contextmenu directionality paste textcolor colorpicker textpattern'
});