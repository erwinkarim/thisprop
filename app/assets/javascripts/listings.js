
var ListingsController = Paloma.controller('Listings');

ListingsController.prototype.new = function(){
	( function(){
	$('#review-tab').on('show.bs.tab', function(e){
		$('#title-output').text( $('#title-input').val() );
		$('#address-output').text( $('#address-input').val() );
		$('#area-output').text( $('#area-input option:selected').text() );
		$('#dwelling-kind-output').text( $('#dwelling-kind-input option:selected').text() );
		$('#description-output').text( $('#description-input').val() );
	});
	})(jQuery);
};

ListingsController.prototype.user_listings = function(){
};

ListingsController.prototype.index = function(){
};
