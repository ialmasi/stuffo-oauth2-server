package Stuffo::OAuth2::Server::Exceptions::BadRequest;

use Moose;

extends 'Stuffo::OAuth2::Server::Exception';

with 'Stuffo::OAuth2::Server::Roles::ExceptionDetails' => {
	code => 400,
};

__PACKAGE__->meta()->make_immutable();

1;