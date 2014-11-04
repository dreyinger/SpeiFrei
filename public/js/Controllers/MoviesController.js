App.MoviesController = Ember.Controller.extend({
	actions: {
    goToMovie: function (param) {
    	this.transitionToRoute('/movie/' + param);
    },
    createMovie: function () {
			this.transitionToRoute('createMovie');
		}
  }
});
