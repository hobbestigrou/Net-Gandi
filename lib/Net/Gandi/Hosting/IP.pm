package Net::Gandi::Hosting::IP;

# ABSTRACT: Ip interface

use Moose;
use MooseX::Params::Validate;
use namespace::autoclean;

use Net::Gandi::Types Client => { -as => 'Client_T' };
use Net::Gandi::Error qw(_validated_params);

use Carp;

=attr id

rw, Int. Id of the ip.

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

=method list

  $ip->list;

List ip addresses.

  input: opts (HashRef) : Filtering options
  output: (HashRef)     : List of ip

=cut

sub list {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->api_call( 'ip.list', $params );
}

=method count

  $ip->count;

Count ip adresses.

  input: opts (HashRef) : Filtering options
  output: (Int)         : number of ip

=cut

sub count {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->api_call('ip.count', $params);
}

=method info

Return a mapping of the IP attributes.

  input: None
  output: (HashRef) : Vm informations

=cut

sub info {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->api_call( 'ip.info', $self->id );
}

=method update

Updates a IP’s attributes

  input: ip_spec (HashRef) : specifications of the ip address to update
  output: (HashRef)        : Operation ip update

=cut

sub update {
    my ( $self, $params ) = validated_list(
        \@_,
        ip_spec => { isa => 'HashRef' }
    );

    carp 'Required parameter id is not defined' if ( ! $self->id );
    _validated_params('ip_update', $params);

    $params ||= {};
    return $self->client->api_call('ip.update', $self->id, $params);
}

#sub attach {
#    my ( $self, $iface_id ) = @_;
#
#    return $self->client->api_call('iface.attach', $iface_id, $self->id);
#}


#sub detach {
#    my ( $self, $iface_id ) = @_;
#
#    return $self->client->api_call('iface.detach', $iface_id, $self->id);
#}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
