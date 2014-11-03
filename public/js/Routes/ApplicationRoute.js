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
		},
		goToMovie: function (param) {
    	  this.transitionTo('/movie/' + param);
    	},
		createDirector: function () {
			this.transitionTo('createDirector');
		},
		editDirector: function () {
			this.transitionTo('editDirector');
		},
		selectDirector: function () {
			this.transitionTo('selectDirector');
		},
		createActor: function () {
			this.transitionTo('createActor');
		},
		editActor: function () {
			this.transitionTo('editActor');
		},
		createStudio: function () {
			this.transitionTo('createStudio');
		}
	}
});
