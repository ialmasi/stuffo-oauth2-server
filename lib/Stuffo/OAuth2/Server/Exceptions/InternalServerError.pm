package Stuffo::OAuth2::Server::Exceptions::InternalServerError;

use Moose;

extends 'Stuffo::OAuth2::Server::Exception';

with 'Stuffo::OAuth2::Server::Roles::ExceptionDetails' => {
	code => 500,
};

__PACKAGE__->meta()->make_immutable()

1;