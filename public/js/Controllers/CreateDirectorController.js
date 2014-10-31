App.CreateDirectorController = Ember.Controller.extend({
	model: {},
	actions: {
		submit_director: function () {
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/director', data);
		}
	}
});