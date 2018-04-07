var app = angular.module("app", ['ui.router']);
app.config(["$stateProvider", "$urlRouterProvider", function($stateProvider, $urlRouterProvider){
	$urlRouterProvider.otherwise("/");
	$stateProvider.state("login", {
		url:"/",
		templateUrl:"templates/login.html"
	});

	$stateProvider.state("signup",{
		url:"/signup",
		templateUrl:"templates/signup.html"
	});

	$stateProvider.state('about', {
		url:"/about",
		template:"<h1>Create by giri</h1>"
	});


}])