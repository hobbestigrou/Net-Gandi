package Net::Gandi::Client;

# ABSTRACT: A Perl interface for gandi api

use Moose;
use MooseX::Types::URI qw(Uri);
use namespace::autoclean;

use Net::Gandi::Types qw(Apikey);

use Module::Load;

with 'MooseX::Traits';

=attr apikey

rw, Apikey. Api key of your Gandi account

=cut

has 'apikey' => (
    is       => 'rw',
    required => 0,
    isa      => Apikey,
);

=attr apikey

rw, Uri. Url of gandi api, default value is current api version

=cut

has 'apiurl' => (
    is      => 'rw',
    isa     => Uri,
    coerce  => 1,
    default => 'https://rpc.gandi.net/xmlrpc/2.0/',
);

=attr useragent

rw, Str. Specified a useragent. The default value is Net::Gandi with the version.

=cut

has 'useragent' => (
    is      => 'rw',
    isa     => 'Str',
    default => "Net::Gandi/1.0",
);

=attr timeout

rw, Int. Timeout in secondes, default to 5.

=cut

has 'timeout' => (
    is      => 'rw',
    isa     => 'Int',
    default => 5,
);

=attr err

rw, Int. Returns the numeric code of last error.

=cut

has 'err' => (
    is      => 'rw',
    isa     => 'Int',
);

=attr errstr

rw, Str. Returns the human readable text for last error.

=cut

has 'errstr' => (
    is      => 'rw',
    isa     => 'Str',
);

=attr date_to_datetime

rw, Bool. To transform the string date in a DateTime object. Use
DateTime::Format::HTTP

=cut

has 'date_to_datetime' => (
    is      => 'rw',
    default => 0,
    isa     => 'Bool',
);

sub _date_to_datetime {
    my ( $self, $object ) = @_;

    ref($object) or return $object;

    load 'DateTime::Format::HTTP';
    my $array        = ref($object) ne 'ARRAY' ? [ $object ] : $object;
    my $dt           = 'DateTime::Format::HTTP';
    my @special_keys = ('ips', 'disks', 'ifaces');

    foreach my $obj (@{$array}) {
        while ( my ($key, $value) = each %{$obj} ) {
            if ( $key ~~ @special_keys ) {
                $self->_date_to_datetime($value);
            }
            $obj->{$key} = $dt->parse_datetime($value) if $key =~ m/date_/;
        }
    }

    return $object;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
