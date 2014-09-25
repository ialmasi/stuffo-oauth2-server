package Stuffo::OAuth2::Server::Authorization::AbstractType;

use Moose;

use MooseX::AbstractMethod;

use Stuffo::OAuth2::Server::ExceptionFactory;

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

has '_client' => (
		is => 'ro',
		isa => 'Stuffo::OAuth2::Server::Models::Client',
		lazy => 1,
		default => sub {
			my $self = shift();

			my $data = $self->storage()
				->get_database( 'oauth2' )->get_collection( 'clients' )
				->find_one( { id => $self->client_id() } );

			Stuffo::OAuth2::Server::ExceptionFactory->create( 'bad_request', { message => 'Client not found!' } )->throw()
				unless( defined( $data ) );

			return Stuffo::OAuth2::Server::Models::Client->unpack( $data );
		}
	);

abstract 'run';

__PACKAGE__->meta()->make_immutable();

1;