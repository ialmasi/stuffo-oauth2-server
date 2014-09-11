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

	$authentication->get( '/' )
		->to( controller => 'Controllers::Authentication', action => 'index' );

	$authentication->post( '/login' )
		->to( controller => 'Controllers::Authentication', action => 'login' );

	# --- OAuth Routes
	my $oauth = $self->routes()->any( '/oauth' );
	
	$oauth->get( '/authorize' )
		->to( controller => 'Controllers::OAuth', action => 'authorize' );

	$oauth->get( '/access_token' )
		->to( controller => 'Controllers::OAuth', action => 'access_token' );

	# --- Admin Routes
	my $admin = $self->routes()->any( '/admin' );

	$admin->get( '/' )
		->to( controller => 'Controllers::Default', action => 'index' );

	# -- API routes
	my $api = $self->routes()->any( '/api' );

	$api->get( '/clients' )
		->to( controller => 'Controllers::API::Clients', action => 'list' );

	$api->get( '/clients/:id' )
		->to( controller => 'Controllers::API::Clients', action => 'show' );

	$api->post( '/clients' )
		->to( controller => 'Controllers::API::Clients', action => 'create' );

	$api->put( '/clients/:id' )
		->to( controller => 'Controllers::API::Clients', action => 'update' );

	$api->delete( '/clients/:id' )
		->to( controller => 'Controllers::API::Clients', action => 'delete' );
}

1;

__END__