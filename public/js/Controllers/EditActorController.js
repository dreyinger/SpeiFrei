App.EditActorController = Ember.Controller.extend({
	model: {},
	actions: {
		edit_actor: function () {
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/editActor', data);
		}
	}
});