package Stuffo::OAuth2::Server::StorageEngine::Backends::Mongo;

use Moose;

extends('Stuffo::OAuth2::Server::StorageEngine::Backend');

use MongoDB;

use Stuffo::OAuth2::Server::Config;

has [qw(database collection)] => (
        is => 'rw',
        isa => 'Str'
    );

sub BUILD {
    my $self = shift;

    my ($database, $collection) = split(/\./, $self->entity);

    $self->database($database);
    $self->collection($collection);
}

has _client => (
        is => 'ro',
        isa => 'MongoDB::MongoClient',
        lazy => 1,
        default => sub {
            return MongoDB::MongoClient->new(
                    %{ $config->get('storage/mongo') || {} }
                );
        }
    );

has _collection => (
        is => 'ro',
        isa => 'MongoDB::Collection',
        lazy => 1,
        default => sub {
            my $self = shift;

            return $self->_client
                    ->get_database($self->database)
                    ->get_collection($self->collection);
        },
        handles => {
            select_one => 'find_one',
            count => 'count',
            insert => 'insert',
            save => 'save',
            update => 'update',
            delete => 'remove'
        }
    );

sub select {
    my $self = shift;
    my $query = shift;

    return [$self->_collection->find($query)->all()];
}

1;

__END__