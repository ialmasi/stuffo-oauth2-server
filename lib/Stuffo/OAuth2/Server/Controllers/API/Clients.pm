package Stuffo::OAuth2::Server::Controllers::API::Clients;

use Mojo::Base 'Mojolicious::Controller';

sub list {
	my $self = shift();

	my @clients = $self->model( 'oauth2.clients' )
		->find()
		->all();

	return $self->render( json => \@clients );
}

sub show {
	my $self = shift();

	my $client = $self->model( 'oauth2.clients' )
		->find_one( { _id => $self->param( 'id' ) } );

	return ( defined( $client ) ) ?
		$self->render( json => $client ) :
		$self->render_not_found();
}

sub create {
	my $self = shift();

	my $id = $self->model( 'oauth2.clients' )
		->insert( $self->req()->json() );

	return $self->render( json => { id => $id } );
}

sub update {
	my $self = shift();

	return $self->render( json => undef );
}

sub delete {
	my $self = shift();

	$self->model( 'oauth2.clients' )
		->remove( { _id => $self->param( 'id' ) }, { just_one => 1 } );

	return $self->render( json => {} );
}

1;