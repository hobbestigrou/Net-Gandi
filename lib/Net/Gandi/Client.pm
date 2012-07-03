package Net::Gandi::Client;

# ABSTRACT: A Perl interface for gandi api

use Moose;
use MooseX::Types::URI qw(Uri);
use Net::Gandi::Types qw(Apikey);

use Module::Load;

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

has 'err' => (
    is      => 'rw',
    isa     => 'Int',
);

has 'errstr' => (
    is      => 'rw',
    isa     => 'Str',
);

has 'date_object' => (
    is      => 'rw',
    default => 0,
    isa     => 'Bool',
);

sub _date_object {
    my ( $self, $object ) = @_;

    load 'DateTime::Format::HTTP';

    my $array = ref($object) ne 'ARRAY' ? [ $object ] : $object;
    my $dt = 'DateTime::Format::HTTP';

    foreach my $obj (@{$array}) {
        while ( my ($key, $value) = each %{$obj} ) {
            $obj->{$key} = $dt->parse_datetime($value) if $key =~ m/date_/;
        }
    }

    return $object;
}

1;
