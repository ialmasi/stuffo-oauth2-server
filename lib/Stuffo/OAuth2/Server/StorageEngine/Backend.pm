package Stuffo::OAuth2::Server::StorageEngine::Backend;

use Moose;
use MooseX::AbstractMethod;

has entity => (
        is => 'rw',
        isa => 'Str',
        required => 1
    );

abstract $_
    foreach ( qw( select select_one count insert save update delete ) );

1;

__END__