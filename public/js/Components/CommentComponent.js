App.CommentContainerComponent = Ember.Component.extend({
	willInsertElement: function () {
		var self = this,
				date = Ember.get(self, 'model.Date'),
				u 	 = JSON.parse(getCookie('auth')).user;

		date = date.toString().slice(0, 16);
		Ember.set(self, 'date', date);
		Ember.$.get('/api/v1/user/' + u).done(function (data) {
			var user 	= JSON.parse(data)[0],
					uName = user.Firstname + " " + user.Surname;
			
			Ember.set(self, 'user', uName);
		});
	},
	actions: {
		deleteComment: function (params) {
			this.sendAction('action', params);
		}
	}
});
