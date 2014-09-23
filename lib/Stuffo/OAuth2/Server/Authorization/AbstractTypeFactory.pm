package Stuffo::OAuth2::Server::Authorization::AbstractTypeFactory;

use MooseX::AbstractFactory;

use String::CamelCase qw( camelize );

implementation_class_via sub {
	return sprintf( 'Stuffo::OAuth2::Server::Authorization::Types::%s',
			join( '::', map { camelize( $_ ) } split( /\./, shift() ) )
		);
};

1;