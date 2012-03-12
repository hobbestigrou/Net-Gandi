package Net::Gandi::Types;

# ABSTRACT: A Perl interface for gandi api

use MooseX::Types::Moose qw/Str ArrayRef HashRef/;
use MooseX::Types -declare => [qw(Client)];

class_type Client, { class => 'Net::Gandi::Client' };

1;
