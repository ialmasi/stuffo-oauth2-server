var app = angular.module( 'stuffo.oauth2.server', 
		[
			'ngRoute',

			'stuffo.oauth2.server.clients'
		] 
	);

app.config( function( $routeProvider ) {
			$routeProvider.when( '/', 
					{
						templateUrl : 'modules/clients/list.html',
						controller : 'ClientsListController'
					} 
				);

			$routeProvider.otherwise( { redirectTo : '/' } );
		}
	);