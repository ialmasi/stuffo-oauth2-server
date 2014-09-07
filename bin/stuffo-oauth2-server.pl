#!/usr/bin/env perl

if( $ENV{STUFFO_OAUTH2_SERVER_DEV} ) {
	use Test::MockObject;

	use Cwd qw( abs_path );
	use File::Basename;

	Test::MockObject->fake_module( 'File::ShareDir',
		dist_dir => sub {
			my $name = shift();

			return abs_path( sprintf( '%s/../share', dirname( abs_path( $0 ) ) ) );
		}
	);
}

use Mojolicious::Commands;

Mojolicious::Commands->start_app( 'Stuffo::OAuth2::Server' );