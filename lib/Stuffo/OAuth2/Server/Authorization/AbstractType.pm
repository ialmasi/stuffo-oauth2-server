package Stuffo::OAuth2::Server::Authorization::AbstractType;

use Moose;

use MooseX::AbstractMethod;

use Stuffo::OAuth2::Server::Models::Client;

has 'storage' => (
		is => 'ro',
		isa => 'Any',
		required => 1,
	);

has 'client_id' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

abstract 'run';

sub _get_client {
	my $self = shift();

	my $data = $self->storage()
		->get_database( 'oauth2' )->get_collection( 'clients' )
		->find_one( { id => $self->client_id() } );

	die( 'Client not found!' )
		unless( defined( $data ) );

	return Stuffo::OAuth2::Server::Models::Client->unpack( $data );
}

sub _store_token {
	my ( $self, $token ) = @_;

	$self->storage()
		->get_database( 'oauth2' )->get_collection( 'tokens' )
		->insert( $token->pack() );
}

__PACKAGE__->meta()->make_immutable();

1;