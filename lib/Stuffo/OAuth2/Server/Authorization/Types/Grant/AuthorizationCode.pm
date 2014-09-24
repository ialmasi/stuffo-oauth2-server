package Stuffo::OAuth2::Server::Authorization::Types::Grant::AuthorizationCode;

use Moose;

extends 'Stuffo::OAuth2::Server::Authorization::AbstractType';

use Stuffo::OAuth2::Server::ModelFactory;
use Stuffo::OAuth2::Server::ExceptionFactory;

use Stuffo::OAuth2::Server::Authentication::PluginFactory;

has 'code' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

has 'redirect_uri' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

has 'client_id' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

has 'client_secret' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

sub run {
	my $self = shift();

	# TODO: Check code in the database...

	# TODO: Retrieve user!
	my $authentication = Stuffo::OAuth2::Server::Authentication::PluginFactory->create( 'dummy', {} );

=begin
	my $user = $authentication->retrieve_by_id()
	die( 'User not found!' )
		unless( defined( $user ) );
=cut

	Stuffo::OAuth2::Server::ExceptionFactory
		->create( 'bad_request', { message => 'Redirect uri does not match!' } )
		->throw()
			unless( $self->_client()->redirect_uri() eq $self->redirect_uri() );

	Stuffo::OAuth2::Server::ExceptionFactory
		->create( 'bad_request', { message => 'Secret does not match!' } )
		->throw()
			unless( $self->_client()->secret() eq $self->client_secret() );

	my $token = Stuffo::OAuth2::Server::ModelFactory->create( 'token', {} );

	# TODO: Store token!

	return $token;
}

__PACKAGE__->meta()->make_immutable();

1;