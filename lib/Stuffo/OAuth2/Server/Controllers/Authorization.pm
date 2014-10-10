package Stuffo::OAuth2::Server::Controllers::Authorization;

use Mojo::Base 'Mojolicious::Controller';

use Stuffo::OAuth2::Server::Authorization::AbstractTypeFactory;

sub authorize {
	my $self = shift();

	eval {
		my $result = Stuffo::OAuth2::Server::Authorization::AbstractTypeFactory->create(
				sprintf( 'response.%s', $self->param( 'response_type' ) ),
				$self->req()->params()->to_hash() 
			)->run();

		return $self->redirect_to( $result )
	};

	if( my $error = $@ ) {
		return $self->render( %{ $error->get_render_data() } )
			if( $error->isa( 'Stuffo::OAuth2::Server::Exception' ) );
	}
}

sub token {
	my $self = shift();

	eval {
		my $result = Stuffo::OAuth2::Server::Authorization::AbstractTypeFactory->create(
				sprintf( 'grant.%s', $self->param( 'grant_type' ) ), 
				$self->req()->params()->to_hash() 
			)->run();

		return $self->render( json => $result->pack() );
	};

	if( my $error = $@ ) {
		return $self->render( %{ $error->get_render_data() } )
			if( $error->isa( 'Stuffo::OAuth2::Server::Exception' ) );

		die( $error );
	}
}

1;