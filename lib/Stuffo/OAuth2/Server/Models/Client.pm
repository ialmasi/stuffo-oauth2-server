package Stuffo::OAuth2::Server::Models::Client;

use Moose;

extends 'Stuffo::OAuth2::Server::Model';

use UUID::Random;

has 'id' => (
		is => 'ro',
		isa => 'Str',
		default => sub {
			return UUID::Random::generate();
		}
	);

has 'name' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

has 'url' => (
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
		default => sub {
			return UUID::Random::generate();
		}
	);

__PACKAGE__->meta()->make_immutable();

1;