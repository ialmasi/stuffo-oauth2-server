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
	$self->home()->parse( sprintf( '%s/web', File::ShareDir::dist_dir( 'Stuffo-OAuthr2-Server' ) ) );

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

	# --- Routes
	$self->routes()->get( '/' )
		->to( controller => 'Controllers::Default', action => 'index' );

	my $admin = $self->routes()->any( '/admin' );
}

1;

__END__