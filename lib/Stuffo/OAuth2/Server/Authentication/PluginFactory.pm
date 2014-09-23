package Stuffo::OAuth2::Server::Authentication::PluginFactory;

use MooseX::AbstractFactory;

use String::CamelCase qw( camelize );

implementation_class_via sub {
	return sprintf( 'Stuffo::OAuth2::Server::Authentication::Plugins::%s',
			join( '::', map { camelize( $_ ) } split( /\./, shift() ) )
		);
};

1;