package Stuffo::OAuth2::Server::Config;

use strict;
use warnings;

use base 'Exporter';

use Config::JSON;

use Stuffo::OAuth2::Server::Constants qw(CONFIG_JSON_PATH);

our @EXPORT = (
        $config
    );

our $config = Config::JSON->new(path());

sub path {
    my $path = CONFIG_JSON_PATH;
}

1;