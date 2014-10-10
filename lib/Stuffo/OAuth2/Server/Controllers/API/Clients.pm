package Stuffo::OAuth2::Server::Controllers::API::Clients;

use Mojo::Base 'Mojolicious::Controller';

use Stuffo::OAuth2::Server::ModelFactory;

sub list_client {
	my $self = shift();

	my $clients = $self->storage_engine
		->storage('clients')
		->select();

	return $self->render( json => $clients );
}

sub read_client {
	my $self = shift();

	my $client = $self->storage_engine
		->storage('clients')
		->select_one({id => $self->param('clientId')});

	return ( defined( $client ) ) ?
		$self->render( json => $client ) :
		$self->render_not_found();
}

sub create_client {
	my $self = shift();

	my $params = $self->req()->json();
	my $client = Stuffo::OAuth2::Server::ModelFactory->create( 'client',
			{
				map { $_ => $params->{ $_ } } 
				grep { defined( $params->{ $_ } ) } qw( name url description redirect_uri )
			}
		);

	my $id = $self->storage_engine
		->storage('clients')
		->insert($client->pack());

	return $self->render( json => { clientId => $id } );
}

sub update_client {
	my $self = shift();

	my $client_db = $self->storage_engine
		->storage('clients')
		->select_one( { id => $self->param( 'clientId' ) } );

	my $params = $self->req()->json();
	my $client = Stuffo::OAuth2::Server::ModelFactory->create( 'client',
			{
				id => $self->param( 'clientId' ),
				map { $_ => $params->{ $_ } || $client_db->{ $_ } } qw( name url description redirect_uri )
			}
		);

	$self->storage_engine
		->storage('clients')
		->update({id => $self->param( 'clientId' )}, { '$set' => $client->pack()});

	return $self->render( json => {} );
}

sub delete_client {
	my $self = shift();

	$self->storage_engine
		->storage('clients')
		->delete( { id => $self->param( 'clientId' ) } );

	return $self->render( json => {} );
}

1;