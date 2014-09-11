package Stuffo::OAuth2::Server::Controllers::Authentication;

use Mojo::Base 'Mojolicious::Controller';

sub index {
	my $self = shift();

	$self->stash( url => $self->param( 'url' ) );

	return $self->render( 'authentication/index' );
}

sub login {
	my $self = shift();

	$self->session( 'user', 
			{
				first_name => 'John',
				last_name => 'Doe',
				email => 'john.doe@domain.com',
			}
		);

	$self->redirect_to( $self->param( 'r' ) )
		if( $self->param( 'r' ) );

	return $self->render( 'authentication/login' );
}

1;