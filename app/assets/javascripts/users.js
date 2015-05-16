
var UsersController = Paloma.controller('Users');

UsersController.prototype.index = function(){
	console.log('loaded users/index');
};

UsersController.prototype.show = function(){
	console.log('loaded users/show');
};

UsersController.prototype.edit = function(){
	console.log('loaded users/edit');
};
