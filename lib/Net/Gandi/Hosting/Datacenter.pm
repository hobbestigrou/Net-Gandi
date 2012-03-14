package Net::Gandi::Hosting::Datacenter;

# ABSTRACT: Datacenter interface

use Moose;
use MooseX::Params::Validate;
use Net::Gandi::Types Client => { -as => 'Client_T' };

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

sub list {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->call_rpc( 'datacenter.list', $params );
}

1;
