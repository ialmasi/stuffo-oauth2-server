package Stuffo::OAuth2::Server;

use Mojo::Base 'Mojolicious';
use Mojo::Log;

use File::ShareDir;

use constant {
	CONFIG_JSON_PATH => '/etc/default/stuffo-oauth2-server.json',
};

our $VERSION = '1.0';

sub startup {
	my $self = shift();

	# --- General configuration
	$self->home()->parse( sprintf( '%s/web', File::ShareDir::dist_dir( 'Stuffo-OAuth2-Server' ) ) );

	$self->static()->paths()->[0] = $self->home()->rel_dir( 'public' );
	$self->renderer()->paths()->[0] = $self->home()->rel_dir( 'templates' );

	# --- Plugins
	my $config = $self->plugin( 'JSONConfig', 
			{ 
				file => CONFIG_JSON_PATH 
			} 
		);

	$self->plugin( 'Mongodb', 
			{
				helper => 'mongo',
				%{ $config->{mongodb} },
			}
		);

	# --- Authentication
	my $authentication = $self->routes()->any( '/' );

	$authentication->get( '/' )->to( 'Controllers::Authentication#index' );
	$authentication->post( '/login' )->to( 'Controllers::Authentication#login' );
	$authentication->get( '/logout' )->to( 'Controllers::Authentication#logout' );

	# --- OAuth Routes
	my $oauth = $self->routes()->any( '/oauth' );
	
	$oauth->bridge( '/authorize' )->to( 'Controllers::Authentication#check' )
		->get( '/' )->to( 'Controllers::Authorization#authorize' );

	$oauth->post( '/token' )->to( 'Controllers::Authorization#token' );

	# --- Admin Routes
	my $admin = $self->routes()->any( '/admin' );

	$admin->get( '/' )->to( 'Controllers::Admin#index' );

	# -- API routes
	my $api = $self->routes()->any( '/api' );

	$api->get( '/clients' )->to( 'Controllers::API::Clients#list' );
	$api->get( '/clients/:id' )->to( 'Controllers::API::Clients#show' );
	$api->post( '/clients' )->to( 'Controllers::API::Clients#create' );
	$api->put( '/clients/:id' )->to( 'Controllers::API::Clients#update' );
	$api->delete( '/clients/:id' )->to( 'Controllers::API::Clients#delete' );
}

1;

__END__