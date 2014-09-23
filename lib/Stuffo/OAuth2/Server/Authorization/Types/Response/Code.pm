package Stuffo::OAuth2::Server::Authorization::Types::Response::Code;

use Moose;

extends 'Stuffo::OAuth2::Server::Authorization::AbstractType';

use Mojo::URL;

use Session::Token;

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

	my $client = $self->_get_client();

	die( 'Redirect uri does not match!' )
		unless( $client->redirect_uri() eq $self->redirect_uri() );

	my $code = Session::Token->new()->get();

	my $url = Mojo::URL->new( $client->redirect_uri() );
	$url->query()->param( code => $code );

	# TODO: Save code somewhere in the database...

	return $url;
}

__PACKAGE__->meta()->make_immutable();

1;