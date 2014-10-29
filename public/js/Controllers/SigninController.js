App.SigninController = Ember.Controller.extend({
	actions: {
		print: function () {
			if (Ember.get(this, "email") && Ember.get(this, "password")) {
				var data = {email: Ember.get(this, "email"), password: Ember.get(this, "password")};
				$.post( "login.json", data, function (d) {
					console.log(JSON.stringify(d));
				});
			} else {
				try {
					throw new Error('Whoops!');
				} catch (e) {alert(e.name + ': ' + e.message);
				}
			}
		}
	}
});
