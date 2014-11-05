App.AccountSettingsController = Ember.Controller.extend({
	actions: {
		delete_account: function () {
			var self = this;
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/deleteAccount', data).done(function(data) {
			data = JSON.parse(data);
				if (data.deleted) {
					Ember.set(self, 'deleted', 'You have deleted this Actor');
					console.log(data);
				}
				else {
					Ember.set(self, 'deleted', 'Something went wrong');
					console.log(data);
				}
			});	
		},
		submitEditAccountSettings: function() {
			var self = this;
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/editAccountSettings', data).done(function(data) {
			data = JSON.parse(data);
			if (data.edited) {
				Ember.set(self, 'edited', 'You have edited this User');
				console.log(data);
			}
			else {
				Ember.set(self, 'edited', 'Any wrong enter - Names must start with an upper case; maybe wrong Birthdate pattern');
				console.log(data);
			}
			});
		}
	}
});