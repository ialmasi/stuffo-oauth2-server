package Stuffo::OAuth2::Server::Exception;

use Moose;

use MooseX::AbstractMethod;

has 'message' => (
		is => 'ro',
		isa => 'Str',
		default => 'Exception'
	);

sub to_string {
	my $self = shift();

	return $message;
}

__PACKAGE__->meta()->make_immutable();

1;