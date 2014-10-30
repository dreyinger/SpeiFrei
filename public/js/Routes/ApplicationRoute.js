App.ApplicationRoute = Ember.Route.extend({		
	actions :   {
		signin: function () {
			this.transitionTo('signin');
		},
		signup: function () {
			this.transitionTo('signup');
		},
		home: function () {
			this.transitionTo('movies');
		},
		studios: function () {
			this.transitionTo('studios');
		},
		actors: function () {
			this.transitionTo('actors');
		},
		directors: function () {
			this.transitionTo('directors');
		},
		createMovie: function () {
			this.transitionTo('createMovie');
		}
	}
});
