package Stuffo::OAuth2::Server::Authentication::Plugin;

use Moose;

use MooseX::AbstractMethod;

abstract 'find_by_credentials';
abstract 'find_by_id';

__PACKAGE__->meta()->make_immutable();

1;