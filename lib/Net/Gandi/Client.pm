package Net::Gandi::Client;

# ABSTRACT: A Perl interface for gandi api

use Moose;
use MooseX::Types::URI qw(Uri);
use Net::Gandi::Types qw(Apikey);

with 'MooseX::Traits';

has 'apikey' => (
    is       => 'rw',
    required => 0,
    isa      => Apikey,
);

has 'apiurl' => (
    is      => 'rw',
    isa     => Uri,
    coerce  => 1,
    default => 'https://rpc.gandi.net/xmlrpc/2.0/',
);

has 'useragent' => (
    is      => 'rw',
    isa     => 'Str',
    default => "Net::Gandi/1.0",
);

has 'timeout' => (
    is      => 'rw',
    isa     => 'Int',
    default => 5,
);

#has 'date_object' => (
#    is      => 'rw',
#    default => 0,
#    isa     => 'Bool',
#);

#sub _date_object {
#    my ( $object ) = @_;
#
#    load Class::Date;
#
#   if ( ref($object) eq 'ARRAY' ) {
#       foreach my $obj (@{$object}) {
#           while ( my ($key, $value) = each %{$obj} ) {
#               if ( $key =~ m/date_/ ) {
#                   $obj->{$key} = Class::Date->new($value);
#               }
#           }
#       }
#   }
#   else {
#       while ( my ($key, $value) = each %{$object} ) {
#           if ( $key =~ m/date_/ ) {
#               $object->{$key} = Class::Date->new($value);
#           }
#       }
#   }

#  return $object;
#}

1;
