package Stuffo::OAuth2::Server::Model;

use Moose;

use MooseX::Storage;

with Storage();

__PACKAGE__->meta()->make_immutable();

1;