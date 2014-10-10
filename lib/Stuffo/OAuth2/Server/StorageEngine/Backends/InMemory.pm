package Stuffo::OAuth2::Server::StorageEngine::Backends::InMemory;

use Moose;

extends('Stuffo::OAuth2::Server::StorageEngine::Backend');

use Time::HiRes;

has _data => (
        is => 'rw',
        isa => 'HashRef[HashRef[Any]]',
        default => sub { {} },
        traits => ['Hash'],
        handles => {
            set => 'set',
            keys => 'keys',
            get => 'get',
            remove => 'delete'
        }
    );

sub insert {
    my ($self, $data) = @_;

    my $id = $data->{_id} || Time::HiRes::time();

    die("Unique key contraint violated")
        if ($self->select_one({_id => $id}));

    $data->{_id} = $id;
    return $self->set($id => $data);
}

sub select {
    my $self = shift;
    my $query = shift;

    return [
        map {
            $self->get($_)
        } @{ $self->get_ids($query) }
    ];
}

sub select_one {
    my $self = shift;
    my $query = shift;

    return (
        map {
            $self->get($_)
        } @{ $self->get_ids($query, 1) }
    )[0];
}

sub count {
    my $self = shift;
    my $query = shift;

    return scalar(@{ $self->get_ids($query) }); 
}

sub update {
    my $self = shift;
    my $query = shift;
    my $update = shift;
    return
        unless ($update && $query);

    my $ids = $self->get_ids($query);
    if ( $update->{'$set'} ) {
        my $set = $update->{'$set'};
        foreach my $id (@$ids) {
            my $data = $self->get($id);
            $data->{$_} = $set->{$_}
                foreach (keys %$set);
            $self->set($id => $data);
        }
    } else {
        $self->set($_ => { %$update, _id => $_ } )
            foreach (@$ids);
    }
}

sub save {
    my $self = shift;
    my $obj = shift;

    my $id = $obj->{_id} || Time::HiRes::time();

    if ( $self->select_one({_id => $id}) ) {
        $self->delete({_id => $id});
    }
    $self->insert($obj);
}

sub delete {
    my $self = shift;
    my $query = shift;

    my $ids = $self->get_ids($query);
    $self->remove($_)
        foreach (@$ids);
}

sub get_ids {
    my $self = shift;
    my $query = shift;
    my $limit = shift;

    return [ $self->keys ]
        unless( $query && scalar(keys %$query));

    my @matches = ();
    foreach my $id ($self->keys) {
        my $row = $self->get($id);
        my $matched = 1;
        foreach my $column (keys %$query) {
            $matched &&= $row->{$column} eq $query->{$column};
        }

        push @matches, $id
            if ($matched);
    }

    return $limit ? [ grep {$_} @matches[0..$limit] ] : \@matches;
}

1;

__END__