
var ListingsController = Paloma.controller('Listings');

var setup_fileupload = function(target){
	$(target).fileupload({
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
			$('#picture-drop-zone').text('Done!!!');
		});

};

ListingsController.prototype.new = function(){
	$(document).ready( function(){ 
		setup_fileupload('#picture-upload-stuff');
	});
};

ListingsController.prototype.edit = function(){
	$(document).ready( function(){ 
		setup_fileupload('#picture-upload-stuff');
	});
};

ListingsController.prototype.user_listings = function(){
};

ListingsController.prototype.index = function(){
};
