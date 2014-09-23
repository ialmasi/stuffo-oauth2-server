package Stuffo::OAuth2::Server::Controllers::Admin;

use Mojo::Base 'Mojolicious::Controller';

sub index {
	my $self = shift();

	return $self->render( 'admin/index' );
}

1;