App.SigninController = Ember.Controller.extend({
	actions: {
		postSignin: function () {
			var self = this;
			if (Ember.get(this, "email") && Ember.get(this, "password")) {
				var data = {email: Ember.get(this, "email"), password: Ember.get(this, "password")};
				Ember.$.get( '/api/v1/user', data).done(function (d) {
					d = JSON.parse(d);
					if (d.auth) {
						setCookie('auth', true, 1);
						Ember.set(self, 'email', undefined);
						Ember.set(self, 'password', undefined);
						Ember.set(self, 'message', undefined);
						self.transitionToRoute('movies');
					} else {
						Ember.set(self, 'message', 'Please enter a valid Username Password combination');
					}
				});
			} else {
				Ember.set(self, 'message', 'Please enter a valid Username Password combination');
			}
		},
		signup: function () {
			this.transitionToRoute('signup');
		}
	}
});
