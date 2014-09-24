package Stuffo::OAuth2::Server::Authorization::Types::Response::Code;

use Moose;

extends 'Stuffo::OAuth2::Server::Authorization::AbstractType';

use Mojo::URL;

use Session::Token;

use Stuffo::OAuth2::Server::ExceptionFactory;
use Stuffo::OAuth2::Server::Models::Client;

has 'redirect_uri' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

has 'scope' => (
		is => 'ro',
		isa => 'Maybe[Str]',
		default => undef,
	);

sub run {
	my $self = shift();

	Stuffo::OAuth2::Server::ExceptionFactory
		->create( 'bad_request', { message => 'Redirect uri does not match!' } )
		->throw()
			unless( $self->_client()->redirect_uri() eq $self->redirect_uri() );

	my $code = Session::Token->new()->get();

	my $url = Mojo::URL->new( $self->_client()->redirect_uri() );
	$url->query()->param( code => $code );

	# TODO: Save code somewhere in the database...

	return $url;
}

__PACKAGE__->meta()->make_immutable();

1;