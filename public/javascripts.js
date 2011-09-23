function search(event) {
	if(event && event.keyCode != '13') return;
	goToCloudPage();
}

function goToCloudPage() {
	var user = document.getElementsByTagName('input')[0].value;
  (user.trim().length > 0) && (window.location='/'+user);
}

