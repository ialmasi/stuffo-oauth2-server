package Stuffo::OAuth2::Server::ModelFactory;

use MooseX::AbstractFactory;

use String::CamelCase qw( camelize );

implementation_class_via sub {
	return sprintf( 'Stuffo::OAuth2::Server::Models::%s', 
			join( '::', map { camelize( $_ ) } split( /\./, shift() ) )
		)
};

1;