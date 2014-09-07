#!/usr/bin/env perl

use Mojolicious::Commands;

Mojolicious::Commands->start_app( 'Stuffo::OAuth2::Server' );