package Stuffo::OAuth2::Server::Constants;

use strict;
use warnings;

use base 'Exporter';

use Package::Constants;

our @EXPORT_OK = Package::Constants->list( __PACKAGE__ );

use constant {
    CONFIG_JSON_PATH => '/etc/default/stuffo-oauth2-server.json',
};

1;