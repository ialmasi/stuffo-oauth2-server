var clients = angular.module( 'stuffo.oauth2.server.clients', 
		[ 'ngResource' ]
	);

clients.factory( 'ClientService', 
		function( $resource ) {
			return $resource( '/api/clients/:id' );
		}
	);

clients.controller( 'ClientsListController', 
		function( $scope, ClientService ) {
			$scope.clients = ClientService.query();

			$scope.deleteClient() = function( client ) {
				client.$delete(
						function() {

						}
					);
			};
		}
	);

clients.controller( 'ClientsNewController',
		function( $scope, ClientService ) {
			$scope.client = new ClientService();

			$scope.registerClient = function() {
				ClientService.save( $scope.client, 
						function() {
							console.log( $scope.client );
						} 
					);
			};
		}
	);