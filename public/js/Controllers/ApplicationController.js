App.MainController = Ember.Controller.extend({
	init: function () {
		var auth = getCookie("auth"),
				self = this;

		if (auth) {
			auth = JSON.parse(auth);
			Ember.set(self, 'auth', auth);
		}
		else {
			Ember.set(self, 'auth', undefined);
		};
	},
	auth: undefined,
	showDrop: false,
	actions :   {
		search: function () {
			this.transitionToRoute('search');
		},
		home: function () {
			this.transitionToRoute('movies');
		},
		studios: function () {
			this.transitionToRoute('studios');
		},
		actors: function () {
			this.transitionToRoute('actors');
		},
		directors: function () {
			this.transitionToRoute('directors');
		},
		users: function () {
			this.transitionToRoute('users');
		},
		account: function () {
			this.toggleProperty('showDrop');
		},
		logout: function () {
			this.toggleProperty('showDrop');
			delCookie('auth');
			this.transitionToRoute('signin');
		},
		accountSettings: function () {
			this.toggleProperty('showDrop');
			this.transitionToRoute('accountSettings');
		}
	}
});
