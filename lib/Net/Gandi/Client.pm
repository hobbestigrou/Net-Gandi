package Net::Gandi::Client;

use Moose;
use MooseX::Types::URI qw(Uri);

with 'MooseX::Traits';

has 'apikey' => (
    is       => 'rw',
    required => 0,
    isa      => 'Str',
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

has 'err' => (
    is      => 'rw',
    isa     => 'Int',
);

has 'errstr' => (
    is      => 'rw',
    isa     => 'Str',
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
