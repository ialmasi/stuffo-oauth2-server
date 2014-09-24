package Stuffo::OAuth2::Server::Exceptions::Forbidden;

use Moose;

extends 'Stuffo::OAuth2::Server::Exception';

with 'Stuffo::OAuth2::Server::Roles::ExceptionDetails' => {
	code => 403,
};

__PACKAGE__->meta()->make_immutable()

1;