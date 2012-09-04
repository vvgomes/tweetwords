function search(event) {
	if(event && event.keyCode != '13') return;
	goToCloudPage();
}

function goToCloudPage() {
	var user = $('#username').val().trim();
  (user.length > 0) && (window.location='/'+user);
}

$.fn.tagcloud.defaults = {
  size: {start: 14, end: 18, unit: 'pt'},
  color: {start: '#cde', end: '#f52'}
};

$(function () {
  $('#cloud a').tagcloud();
});