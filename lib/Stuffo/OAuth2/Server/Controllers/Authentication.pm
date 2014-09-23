package Stuffo::OAuth2::Server::Controllers::Authentication;

use Mojo::Base 'Mojolicious::Controller';

use Stuffo::OAuth2::Server::Authentication::PluginFactory;

sub index {
	my $self = shift();

	# If the user is already logged in then we simply redirect to the given url
	$self->redirect_to( $self->param( 'url' ) )
		if( $self->session( 'user' ) );

	# ... otherwise we display the login page ...
	$self->stash( url => $self->param( 'url' ) );

	return $self->render( 'authentication/index' );
}

sub login {
	my $self = shift();

	# Signal back if no redirection url was provided.
	unless( $self->param( 'url' ) ) {
		$self->flash( message =>'No url provided!' );
		$self->redirect_to( $self->req()->headers()->referrer() );
	}

	# Instantiate the authentication plugin ...
	my $plugin = Stuffo::OAuth2::Server::Authentication::PluginFactory->create(
			$self->config()->{authentication}->{name},
			$self->config()->{authentication}->{args} || {},
		);

	# Check the credentials ...
	my $user = $plugin->find_by_credentials( $self->req()->params()->to_hash() );

	# If the user is not valid then we try again...
	unless( defined( $user ) ) {
		$self->flash( message =>'Invalid credentials!' );
		$self->redirect_to( $self->req()->headers()->referrer() );
	} else {
		$self->session( user => $user );
		$self->redirect_to( $self->param( 'url' ) );
	}
}

sub logout {
	my $self = shift();

	# Delete session
	$self->session( expires => 1 );
	$self->redirect_to( '/' );
}

sub check {
	my $self = shift();

	unless( $self->session( 'user' ) ) {
		$self->redirect_to(
				$self->url_for( '/' )->query( url => $self->url_with() )
			);

		return 0;
	}

	return 1;
}

1;