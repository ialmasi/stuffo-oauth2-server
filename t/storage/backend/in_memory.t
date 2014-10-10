#! /usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Exception;

use constant TARGET_CLASS => 'Stuffo::OAuth2::Server::StorageEngine::Backends::InMemory';

BEGIN {
    $ENV{STUFFO_OAUTH2_SERVER_TESTING} = 1;
    use_ok(TARGET_CLASS);
};

test_interface();
test_functionality();

done_testing();

sub test_interface {
    ok( my $client = TARGET_CLASS->new(entity => 'anything') );

    ok($client->can('save'));
    ok($client->can('insert'));
    ok($client->can('select'));
    ok($client->can('select_one'));
    ok($client->can('delete'));
}

sub test_functionality {
    my $client = TARGET_CLASS->new(entity => 'anything');

    my $obj = {_id => 1, a => 1};
    ok($client->insert($obj));
    is_deeply($client->select_one({_id => 1}), $obj, 'select_one');

    dies_ok {$client->insert($obj)} 'unique key violated';
}