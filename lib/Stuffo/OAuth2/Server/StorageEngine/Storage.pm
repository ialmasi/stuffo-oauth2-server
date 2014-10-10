package Stuffo::OAuth2::Server::StorageEngine::Storage;

use Moose;
use MooseX::ClassAttribute;

use Stuffo::OAuth2::Server::Config;

class_has entity => (
        is => 'ro',
        isa => 'Str'
    );    

has 'backend' => (
        is => 'ro',
        isa => 'Stuffo::OAuth2::Server::StorageEngine::Backend',
        lazy => 1,
        default => sub {
            my $self = shift;

            require Stuffo::OAuth2::Server::StorageEngine::BackendFactory;
            return Stuffo::OAuth2::Server::StorageEngine::BackendFactory->create( '', 
                    {
                        entity => $self->entity
                    }
                );
        },
        handles => {
            map {
                $_ => $_
            } qw(select select_one count insert save update delete)
        }
    );

__PACKAGE__->meta()->make_immutable();

1;