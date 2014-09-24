package Stuffo::OAuth2::Server::Exceptions::Unauthorized;

use Moose;

extends 'Stuffo::OAuth2::Server::Exception';

with 'Stuffo::OAuth2::Server::Roles::ExceptionDetails' => {
	code => 401,
};

__PACKAGE__->meta()->make_immutable()

1;