package Stuffo::OAuth2::Server::StorageEngine::BackendFactory;

use MooseX::AbstractFactory;

use String::CamelCase qw( camelize );

use Stuffo::OAuth2::Server::Config;

implementation_class_via sub {
    return sprintf('Stuffo::OAuth2::Server::StorageEngine::Backends::%s', camelize( $ENV{STUFFO_OAUTH2_SERVER_TESTING} ? 'in_memory' : $config->get('storage/active_backend')));
};

1;

__END__