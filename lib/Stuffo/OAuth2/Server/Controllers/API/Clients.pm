package Stuffo::OAuth2::Server::Controllers::API::Clients;

use Mojo::Base 'Mojolicious::Controller';

use Stuffo::OAuth2::Server::ModelFactory;

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
		->find_one( { id => $self->param( 'id' ) } );

	return ( defined( $client ) ) ?
		$self->render( json => $client ) :
		$self->render_not_found();
}

sub create {
	my $self = shift();

	my $params = $self->req()->json();
	my $client = Stuffo::OAuth2::Server::ModelFactory->create( 'client',
			{
				map { $_ => $params->{ $_ } } 
				grep { defined( $params->{ $_ } ) } qw( name url description redirect_uri )
			}
		);

	my $id = $self->model( 'oauth2.clients' )
		->insert( $client->pack() );

	return $self->render( json => { id => $id } );
}

sub update {
	my $self = shift();

	my $client = $self->model( 'oauth2.clients' )
		->find_one( { id => $self->param( 'id' ) } );

	# TODO: Save into the database ...

	return $self->render( json => undef );
}

sub delete {
	my $self = shift();

	$self->model( 'oauth2.clients' )
		->remove( { id => $self->param( 'id' ) }, { just_one => 1 } );

	return $self->render( json => {} );
}

1;