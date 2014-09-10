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
						controller : 'ClientsListController'
					} 
				);

			$routeProvider.when( '/clients/new',
					{
						templateUrl: '/modules/clients/new.html',
						controller: 'ClientsNewController'
					}
				);

			$routeProvider.otherwise( { redirectTo : '/clients' } );
		}
	);