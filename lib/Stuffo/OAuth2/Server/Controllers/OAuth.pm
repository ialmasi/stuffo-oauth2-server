package Stuffo::OAuth2::Server::Controllers::OAuth;

use Mojo::Base 'Mojolicious::Controller';

sub index {
	my $self = shift();

	return $self->render( 'oauth/login' );
}

sub login {
	my $self = shift();

	$self->redirect_to( '' );
}

sub authorize {
	my $self = shift();

	$self->redirect_to( '/oauth/login' )
		unless( $self->session( 'auth' ) );

	return $self->render( 'oauth/authorize' );
}

sub confirm_authorization {
	my $self = shift();
}

sub access_token {
	my $self = shift();

	return $self->render( json => {} );
}

1;