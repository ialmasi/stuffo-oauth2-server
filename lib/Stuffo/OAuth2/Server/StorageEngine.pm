package Stuffo::OAuth2::Server::StorageEngine;

use Moose;

use Stuffo::OAuth2::Server::StorageEngine::StorageFactory;

has _storage_cache => (
        is => 'rw',
        isa => 'HashRef[Stuffo::OAuth2::Server::StorageEngine::Storage]',
        default => sub { {} },
        traits => ['Hash'],
        handles => {
            cache_storage => 'set',
            storage_is_cached => 'exists',
            get_storage => 'get'
        }
    );

sub storage {
    my ($self, $storage_name) = @_;

    if ( $self->storage_is_cached($storage_name) ) {
        return $self->get_storage($storage_name);
    } else {
        my $storage = Stuffo::OAuth2::Server::StorageEngine::StorageFactory->create( $storage_name, 
                {}
            );

        $self->cache_storage($storage_name => $storage);

        return $storage;
    }
}

__PACKAGE__->meta()->make_immutable();

package Mojolicious::Plugins::StuffoStorageEngine;

use Mojo::Base 'Mojolicious::Plugin';

sub register {
    my ($self, $app, $conf) = @_;

    my $engine = Stuffo::OAuth2::Server::StorageEngine->new();

    $app->helper(
            storage_engine => sub {
                return $engine;
            }
        );
}

1;

__END__