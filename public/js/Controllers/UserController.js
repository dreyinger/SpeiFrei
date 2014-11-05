App.UserController = Ember.Controller.extend({
	// modelObserver: function () {
	// 	var self = this;
	// 	Ember.$.get('/api/v1/moviesForActor', {persId: Ember.get(self, 'model.PersID')}).done(function (data) {
	// 		Ember.set(self, 'movies', data);
	// 	});
	// }.observes('model'),
	// actions: {
	// 	delete_actor: function () {
	// 		var self = this;
	// 		var data = Ember.get(this, 'model');
	// 		Ember.$.post('/api/v1/deleteActor', data).done(function(data) {
	// 		data = JSON.parse(data);
	// 			if (data.deleted) {
	// 				Ember.set(self, 'deleted', 'You have deleted this Actor');
	// 				console.log(data);
	// 			}
	// 			else {
	// 				Ember.set(self, 'deleted', 'Something went wrong');
	// 				console.log(data);
	// 			}
	// 		});	
	// 	},
	// 	goToMovie: function (id) {
	// 		this.transitionToRoute('/movie/' + id);
	// 	}
	// }
});
