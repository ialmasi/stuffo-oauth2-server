#! /usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Mojo;

use Stuffo::OAuth2::Server::Helpers::Test;

BEGIN {
    test_env('../../../share');
};

my $id = 1;
Test::MockObject->new()
    ->fake_module('UUID::Random',
        generate => sub {
            return $id++;
        }
    );
my $_id = 10;
Test::MockObject->new()
    ->fake_module('Time::HiRes',
        time => sub () {
            return $_id++;
        }
    );

# Initialize app
my $test = Test::Mojo->new('Stuffo::OAuth2::Server');

my $test_object = {
    name => 'New app',
    url => 'http://localhost/home',
    redirect_uri => 'http://localhost/landing_page',
    description => 'Mobile app using the api'
};

# create a new client
$test->post_ok( '/api/clients' => json => $test_object )
    ->status_is(200)
    ->header_is('Server' => 'Mojolicious (Perl)')
    ->json_is( { id => 1 } );

$test->get_ok( '/api/clients' )
    ->status_is(200)
    ->header_is('Server' => 'Mojolicious (Perl)')
    ->json_is(
        [
            {
                id => 1,
                secret => 2,
                _id => 10,
                __CLASS__ => 'Stuffo::OAuth2::Server::Models::Client',
                %$test_object
            }
        ]
    );

$test->put_ok( '/api/clients/1' => json => {name => 'Enhanced app'} )
    ->status_is(200)
    ->header_is('Server' => 'Mojolicious (Perl)')
    ->json_is( { id => 1 } );

$test->get_ok( '/api/clients/1' )
    ->status_is(200)
    ->header_is('Server' => 'Mojolicious (Perl)')
    ->json_is(
        {
            %$test_object,
            id => 1,
            secret => 2,
            _id => 10,
            __CLASS__ => 'Stuffo::OAuth2::Server::Models::Client',
            name => 'Enhanced app'
        }
    );

$test->delete_ok( '/api/clients/1' )
    ->status_is(200)
    ->header_is('Server' => 'Mojolicious (Perl)')
    ->json_is( { id => 1 } );

$test->get_ok( '/api/clients' )
    ->status_is(200)
    ->header_is('Server' => 'Mojolicious (Perl)')
    ->json_is( [ ] );

$test->get_ok( '/api/clients/1' )
    ->status_is(404)
    ->header_is('Server' => 'Mojolicious (Perl)');

done_testing();