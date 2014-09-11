var clients = angular.module( 'stuffo.oauth2.server.clients', 
		[ 'ngResource' ]
	);

clients.factory( 'ClientService', 
		function( $resource ) {
			return $resource( '/api/clients/:id', { id: '@id' } );
		}
	);

clients.controller( 'ClientListController', 
		function( $scope, ClientService ) {
			$scope.loadClients = function() {
				ClientService.query(
						function( data ) {
							$scope.clients = data;
						}
					);
			};

			$scope.deleteClient = function( client ) {
				client.$delete( {},
					function() {
							$scope.loadClients();
						}
					);
			};

			$scope.loadClients();
		}
	);

clients.controller( 'ClientCreateController',
		function( $scope, $location, ClientService ) {
			$scope.client = new ClientService();

			$scope.registerClient = function() {
				ClientService.save( $scope.client, 
						function() {
							$location.url( '/clients' );
						} 
					);
			};
		}
	);

clients.controller( 'ClientUpdateController',
		function( $scope, $routeParams, $location, ClientService ) {
			$scope.updateClient = function() {
				$scope.client.$update(
						function() {
							$location.url( '/clients' );
						}
					);
			};

			$scope.loadClient = function() {
				$scope.client = ClientService.get( { id: $routeParams.id } );
			};

			$scope.loadClient();
		}
	);