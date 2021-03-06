App.MovieController = Ember.Controller.extend({
	modelObserver: function () {
		var self = this;
		var studioId = self.get('model.StudioID');
		var directorId = self.get('model.D_PersID');
		if (studioId) {
			Ember.$.get('/api/v1/studio/' + studioId).done(function (data) {
				Ember.set(self, "studioName", data[0].Name);
			});
		} else {
			Ember.set(self, "studioName", "unknown");
		}
		if (directorId) {
			Ember.$.get('/api/v1/director/' + directorId).done(function (data) {
				var directorName = data[0].Firstname + " " + data[0].Surname;
				Ember.set(self, "directorName", directorName);
			});
		} else {
			Ember.set(self, "directorName", "unknown");
		}
		Ember.$.get('/api/v1/actorsForMovie', {movieId: Ember.get(self, 'model.MovieID')}).done(function (data) {
			Ember.set(self, 'actors', data);
		});
		Ember.$.get('/api/v1/commentsForMovie', {movieId: Ember.get(self, 'model.MovieID')}).done(function (data) {
			if (data.length > 1) Ember.set(self, 'comments', data);
		});
	}.observes('model'),
	ratingObserver: function (obj, attr) {
		var self = this;
		val = Ember.get(obj, attr);
		if (val) {
			Ember.$.post('/api/v1/rating', {rating: val, movieId: Ember.get(obj, 'model.MovieID')}).done(function (data) {
				data = JSON.parse(data);
				Ember.set(self, 'model.AvgRating', data.newRating);
			});
		}
	}.observes('selectedValue'),
	ratings: [
		{label: "1 Star", value: 1},
		{label: "2 Star", value: 2},
		{label: "3 Star", value: 3},
		{label: "4 Star", value: 4},
		{label: "5 Star", value: 5}
	],
	actions: {
		delete_movie: function () {
			var self = this;
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/deleteMovie', data).done(function(data) {
				data = JSON.parse(data);
				if (data.deleted) {
					Ember.set(self, 'deleted', 'You have deleted this Movie');
				}
				else {
					Ember.set(self, 'deleted', 'Something went wrong');
				}
			});
		},
		goToActor: function (id) {
			this.transitionToRoute('/actor/' + id);
		},
		goToDirector: function (id) {
			this.transitionToRoute('/director/'+ id);
 		},
 		goToStudio: function (id) {
 			if (id) {
				this.transitionToRoute('/studio/'+ id);
			}
 		},
 		comment: function () {
 			var self 		= this,
 					cText 	= Ember.get(self, 'commentText'),
 					user 		= JSON.parse(getCookie('auth')).user,
 					movieId = Ember.get(self, 'model.MovieID'),
 					data 		= {movieId: movieId, text: cText, user: user};

 			Ember.$.post('/api/v1/addComment', data).done(function () {
 				Ember.$.get('/api/v1/commentsForMovie', {movieId: movieId}).done(function (data) {
 					Ember.set(self, 'comments', data);
 				});
 				Ember.set(self, 'commentText', undefined);
 			});
 		},
 		deleteComment: function (params) {
 			var self		= this,
 					movieId = Ember.get(self, 'model.MovieID');
 			Ember.$.post('/api/v1/deleteComment', {cId: params}).done(function (data) {
 				Ember.$.get('/api/v1/commentsForMovie', {movieId: movieId}).done(function (data) {
 					Ember.set(self, 'comments', data);
 				});
 			});
 		},
		editMovie: function () {
			var data = Ember.get(this, 'model');
			this.transitionToRoute('/editMovie/' + data.MovieID);
		}
	}
});
