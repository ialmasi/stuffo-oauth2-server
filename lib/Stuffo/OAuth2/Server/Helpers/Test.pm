package Stuffo::OAuth2::Server::Helpers::Test;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT = qw(
        test_env
    );

sub test_env {
    $ENV{STUFFO_OAUTH2_SERVER_TEST} = 1;

    if( $ENV{STUFFO_OAUTH2_SERVER_DEV} ) {
        my $path = shift || '../share';

        require Test::MockObject;
        require Cwd;
        require File::Basename;

        Test::MockObject->new()->fake_module( 'File::ShareDir',
            dist_dir => sub {
                my $name = shift();

                return Cwd::abs_path( sprintf( '%s/%s', File::Basename::dirname( Cwd::abs_path( $0 ) ), $path ) );
            }
        );
    }
}