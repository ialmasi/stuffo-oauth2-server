package Stuffo::OAuth2::Server::Controllers::Authorization;

use Mojo::Base 'Mojolicious::Controller';

use Stuffo::OAuth2::Server::Authorization::AbstractTypeFactory;

sub authorize {
	my $self = shift();

	my $result = Stuffo::OAuth2::Server::Authorization::AbstractTypeFactory->create(
			sprintf( 'response.%s', $self->param( 'response_type' ) ),
			{ 
				storage => $self->mongodb_connection(),

				%{ $self->req()->params()->to_hash() }
			},
		)->run();

	return $self->render( json => $result );
}

sub token {
	my $self = shift();

	my $result = Stuffo::OAuth2::Server::Authorization::AbstractTypeFactory->create(
			sprintf( 'grant.%s', $self->param( 'grant_type' ) ),
			{ 
				storage => $self->mongodb_connection(),

				%{ $self->req()->params()->to_hash() }
			},
		)->run();

	return $self->render( json => $result->pack() );
}

1;

__DATA__

my $data = $self->model( 'oauth2.clients' )
	->find_one( { id => $self->param( 'client_id' ) } );

my $client = Stuffo::OAuth2::Server::Models::Client->unpack( $data );

$self->stash( client => $client );

return $self->render( 'authorization/authorize' );