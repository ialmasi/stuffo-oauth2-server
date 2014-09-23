package Stuffo::OAuth2::Server::Exceptions::InternalServerError;

use Moose;

extends 'Stuffo::OAuth2::Server::Exception';

__PACKAGE__->meta()->make_immutable()

1;