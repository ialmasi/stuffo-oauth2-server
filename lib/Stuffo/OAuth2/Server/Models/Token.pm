package Stuffo::OAuth2::Server::Models::Token;

use Moose;

extends 'Stuffo::OAuth2::Server::Model';

use Session::Token;

has 'access_token' => (
		is => 'ro',
		isa => 'Str',
		lazy => 1,
		default => sub {
			return Session::Token->new( entropy => 256 )
				->get();
		}
	);

has 'user' => (
		# traits => [ 'DoNotSerialize' ],
		is => 'ro',
		isa => 'Maybe[HashRef]',
		default => undef,
	);

__PACKAGE__->meta()->make_immutable();

1;