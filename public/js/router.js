App.Router.map(function () {
  this.resource('movies', {path: '/'});
  this.resource('movie', {path: '/movie/:movie_id'});
  this.resource('signin', {path: '/signin'});
  this.resource('signup', {path: '/signup'});
  this.resource('studios', {path: '/studios'});
  this.resource('studio', {path: '/studio/:studio_id'});
  this.resource('actors', {path: '/actors'});
	this.resource('directors', {path: '/directors'});
	this.resource('createMovie', {path: '/createMovie'});
	this.resource('createDirector', {path: '/createDirector'});
	this.resource('editDirector', {path: '/editDirector'});
});
