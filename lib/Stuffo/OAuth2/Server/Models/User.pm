package Stuffo::OAuth2::Server::Models::User;

use Moose;


has 'email' => (
	);

has 'password' => (
	);

__PACKAGE__->meta()->make_immutable();

1;