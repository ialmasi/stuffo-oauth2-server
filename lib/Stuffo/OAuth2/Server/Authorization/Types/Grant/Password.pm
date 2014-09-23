package Stuffo::OAuth2::Server::Authorization::Types::Grant::Password;

use Moose;

extends 'Stuffo::OAuth2::Server::Authorization::AbstractType';

use Stuffo::OAuth2::Server::ModelFactory;
use Stuffo::OAuth2::Server::Authentication::PluginFactory;

has 'username' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

has 'password' => (
		is => 'ro',
		isa => 'Str',
		required => 1
	);

sub run {
	my $self = shift();

	my $client = $self->_get_client();

	# TODO: Figure a way to retrieve this information
	my $authentication = Stuffo::OAuth2::Server::Authentication::PluginFactory->create( 'dummy', {} );

	my $user = $authentication->find_by_credentials(
			{
				username => $self->username(),
				password => $self->password(),
			} 
		);

	die( 'User not found!' )
		unless( defined( $user ) );

	my $token = Stuffo::OAuth2::Server::ModelFactory->create( 'token',
			{
				user => $user,
			}
		);

	# TODO: Save the token in the storage engine...
	# $self->_store_token( $token );

	return $token;
}

__PACKAGE__->meta()->make_immutable();

1;