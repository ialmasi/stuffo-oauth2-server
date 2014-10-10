package Stuffo::OAuth2::Server::StorageEngine::Storage::Token;

use Moose;
use MooseX::ClassAttribute;

extends('Stuffo::OAuth2::Server::StorageEngine::Storage');

class_has '+entity' => (
        default => 'oauth2.tokens'
    );

__PACKAGE__->meta()->make_immutable();

1;

__END__