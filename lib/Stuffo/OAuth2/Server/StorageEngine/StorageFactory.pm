package Stuffo::OAuth2::Server::StorageEngine::StorageFactory;

use MooseX::AbstractFactory;

use String::CamelCase qw( camelize );

implementation_class_via sub {
    return sprintf('Stuffo::OAuth2::Server::StorageEngine::Storage::%s', camelize($_[0]));
};

1;

__END__