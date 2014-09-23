package Stuffo::OAuth2::Server::Authorization::Types::Grant::RefreshToken;

use Moose;

extends 'Stuffo::OAuth2::Server::Authorization::AbstractType';

has 'refresh_token' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

sub run {
	my $self = shift();
}

__PACKAGE__->make()->make_immutable();

1;