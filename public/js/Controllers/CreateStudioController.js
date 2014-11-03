App.CreateStudioController = Ember.Controller.extend({
	model: {},
	actions: {
		submit_studio: function () {
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/createStudio', data);
		}
	}
});