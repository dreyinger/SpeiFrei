App.Router.map(function () {
  this.resource('movies', {path: '/'});
  this.resource('movie', {path: '/movie/:movie_id'});
  this.resource('signin', {path: '/signin'});
  this.resource('signup', {path: '/signup'});
  this.resource('studios', {path: '/studios'});
  this.resource('studio', {path: '/studio/:studio_id'});
  this.resource('users', {path: '/users'});
  this.resource('user', {path: '/user/:email'});
  this.resource('actors', {path: '/actors'});
  this.resource('actor', {path: '/actor/:persID'});
	this.resource('directors', {path: '/directors'});
	this.resource('createMovie', {path: '/createMovie'});
	this.resource('deleteMovie', {path: '/deleteMovie'});	
	this.resource('editMovie', {path: '/editMovie'});
	this.resource('createDirector', {path: '/createDirector'});
	this.resource('editDirector', {path: '/editDirector'});
	this.resource('director', {path: '/director/:persID'});
	this.resource('createActor', {path: '/createActor'});
	this.resource('editActor', {path: '/editActor'});
	this.resource('createStudio', {path: '/createStudio'});
	this.resource('editStudio', {path: '/editStudio/:studio_id'});
	this.resource('search', {path: '/search'});
});
