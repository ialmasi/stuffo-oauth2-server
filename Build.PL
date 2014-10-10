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
			'Config::JSON' => undef,
			'File::ShareDir' => undef,
			'Mojolicious' => undef,
			'Mojolicious::Plugin::REST' => undef,
			'MongoDB' => undef,
			'Moose' => undef,
			'MooseX::AbstractFactory' => undef,
			'MooseX::AbstractMethod' => undef,
			'MooseX::ClassAttribute' => undef,
			'MooseX::Role::Parameterized' => undef,
			'MooseX::Storage' => undef,
			'Package::Constants' => undef,
			'Session::Token' => undef,
			'String::CamelCase' => undef,
			'Test::Exception' => undef,
			'Test::MockObject' => undef,
			'Test::More' => undef,
			'Test::Pod' => undef,
			'URI' => undef,
			'UUID::Random' => undef,
		},
	);

$builder->create_build_script();