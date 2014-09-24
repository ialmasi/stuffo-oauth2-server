package Stuffo::OAuth2::Server::Authorization::Types::Grant::UserCredentials;

use Moose;

extends 'Stuffo::OAuth2::Server::Authorization::AbstractType';

use Stuffo::OAuth2::Server::ModelFactory;
use Stuffo::OAuth2::Server::ExceptionFactory;

has 'client_secret' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

sub run {
	my $self = shift();

	Stuffo::OAuth2::Server::ExceptionFactory
		->create( 'bad_request', { message => 'Secrets do not match' } )
		->throw()
			unless( $self->_client()->secret() eq $self->client_secret() );

	my $token = Stuffo::OAuth2::Server::ModelFactory->create( 'token', {} );

	# TODO: Store token in the storage engine...

	return $token;
}

__PACKAGE__->meta()->make_immutable();

1;