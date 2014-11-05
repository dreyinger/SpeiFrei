App.MainController = Ember.Controller.extend({
	init: function () {
		if (!getCookie("auth")) {
			this.transitionToRoute('signin');
		};
	},
	auth: JSON.parse(getCookie("auth")),
	showDrop: false,
	actions :   {
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
