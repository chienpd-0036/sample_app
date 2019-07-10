$(document).ready(function(){
    $("#micropost_picture").bind("change", function() {
      var size_in_megabytes = this.files[0].size/1024/1024;
      if (size_in_megabytes > Settings.micropost.image_max_size) {
        alert(t(".alert_max_size"));
      }
    });
});
