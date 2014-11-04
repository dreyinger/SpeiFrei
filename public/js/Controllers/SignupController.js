App.SignupController = Ember.Controller.extend({
	params: {},
	test: "test",
	actions: {
		postSignup: function () {
			var self = this;
			if (Ember.get(self, "params.email") && Ember.get(self, "params.password") && Ember.get(self, "params.firstname") && Ember.get(self, "params.surname")) {
				var data = Ember.get(self, 'params')
				console.log("data" + data);
				Ember.$.post( '/api/v1/createUser', data).done(function (d) {
					console.log(d);
					// if (d) {
					// 	setCookie('auth', true, 1);
					// 	Ember.set(self, 'params', Ember.Object.create());
					// 	Ember.set(self, 'message', undefined);
					// 	self.transitionToRoute('movies');
					// }
				});
			} else {
				Ember.set(self, 'message', 'Please enter at least your email, password, firstname and your surname');
			}
		},
		signin: function () {
			this.transitionToRoute('signin');
		}
	}
})
