
var ListingsController = Paloma.controller('Listings');

ListingsController.prototype.new = function(){
	$(document).ready( function(){
		$('#picture-upload-stuff').fileupload({
			url:'/listing_pictures',
			done: function(e,data){
				$.each(jQuery.parseJSON(data.result).files, function(index,file){
					$.get(file.thumbnail_template, function(data){
						$('#listing-pictures').append(data);
					});
				});
			}
		}).bind('fileuploadadd', function(e,data){
			//think about client-side resize later
			$('#picture-drop-zone').text('Uploading pictures...');
		}).bind('fileuploadalways', function(e,data){
			$('#picture-drop-zone').text('Drop Files in this page or ...');
		});
	});
};

ListingsController.prototype.user_listings = function(){
};

ListingsController.prototype.index = function(){
};
