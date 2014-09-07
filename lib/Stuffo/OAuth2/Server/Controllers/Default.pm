package Stuffo::OAuth2::Server::Controllers::Default;

use Mojo::Base 'Mojolicious::Controller';

sub index {
	my $self = shift();

	return $self->render( 'default/index' );
}

1;