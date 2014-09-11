var app = angular.module( 'stuffo.oauth2.server', 
		[
			'ngRoute',

			'stuffo.oauth2.server.clients'
		] 
	);

app.config( function( $routeProvider ) {
			$routeProvider.when( '/clients',
					{
						templateUrl : '/modules/clients/list.html',
						controller : 'ClientListController'
					} 
				);

			$routeProvider.when( '/clients/new',
					{
						templateUrl: '/modules/clients/new.html',
						controller: 'ClientCreateController'
					}
				);

			$routeProvider.when( '/clients/edit/:id',
					{
						templateUrl: '/modules/clients/edit.html',
						controller: 'ClientUpdateController'
					}
				);

			$routeProvider.otherwise( { redirectTo : '/clients' } );
		}
	);