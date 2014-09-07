package Stuffo::OAuth2::Server::Models::Client;

use Moose;

extends 'Stuffo::OAuth2::Server::Model';

has 'uid' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

has 'name' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

has 'description' => (
		is => 'ro',
		isa => 'Maybe[Str]',
		default => undef,
	);

has 'redirect_uri' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

has 'secret' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

__PACKAGE__->meta()->make_immutable();

1;