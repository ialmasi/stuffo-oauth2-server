package Stuffo::OAuth2::Server::Authentication::Plugins::Dummy;

use Moose;

extends 'Stuffo::OAuth2::Server::Authentication::Plugin';

sub find_by_credentials {
	my ( $self, $args ) = @_;

	return ( lc( $args->{username} ) eq 'test' ) ?
		{ 
			name => 'John Doe',
			email => 'john.doe@domain.com',
			description => 'Dummy user',
		} : undef;
}

sub find_by_id {
	my ( $self, $args ) = @_;
}

__PACKAGE__->meta()->make_immutable();

1;