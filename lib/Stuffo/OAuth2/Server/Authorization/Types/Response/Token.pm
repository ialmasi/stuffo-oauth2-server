package Stuffo::OAuth2::Server::Authorization::Types::Response::Token;

use Moose;

extends 'Stuffo::OAuth2::Server::Authorization::AbstractType';

sub run {
	my $self = shift();
}

__PACKAGE__->meta()->make_immutable();

1;