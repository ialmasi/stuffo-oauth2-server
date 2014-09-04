#!/usr/bin/env perl

use strict;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
		module_name => 'Stuffo::OAuth2::Server',

		dist_author => 'Tudor Marghidanu',
		dist_abstract => 'OAuth2 server implementation',

		share_dir => 'share',

		# NOTE: Keep this list sorted!
		requires => {
			'Mojolicious' => undef,
			'Moose' => undef,
			'MooseX::AbstractMethod' => undef,
			'MooseX::AsbtractFactory' => undef,
			'MooseX::ClassAttribute' => undef,
			'MooseX::Storage' => undef,
			'String::CamelCase' => undef,
		},
	);

$builder->create_build_script();