App.CreateActorController = Ember.Controller.extend({
	model: {},
	actions: {
		submit_actor: function () {
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/createActor', data);
		}
	}
});