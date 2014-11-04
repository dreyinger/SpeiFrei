App.MoviesController = Ember.Controller.extend({
	actions: {
    goToMovie: function (param) {
    	this.transitionToRoute('/movie/' + param);
    },
    editMovie: function () {
			this.transitionTo('editMovie');
		},
    createMovie: function () {
			this.transitionToRoute('createMovie');
		}
  }
});
