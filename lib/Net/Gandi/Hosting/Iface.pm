package Net::Gandi::Hosting::Iface;

# ABSTRACT: Iface interface

use Moose;
use MooseX::Params::Validate;
use Net::Gandi::Types Client => { -as => 'Client_T' };
use Net::Gandi::Error qw(_validated_params);

use Carp;

has 'id' => ( is => 'rw', isa => 'Int' );

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
    return $self->client->call_rpc( "iface.list", $params );
}

sub count {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->call_rpc('iface.count', $params);
}

=head1 info

Returns informations about the network interface

=cut

sub info {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc( 'iface.info', $self->id );
}

=head1 create

Create a iface.

=cut

sub create {
    my ( $self, $params ) = validated_list(
        \@_,
        iface_spec => { isa => 'HashRef' }
    );

    _validated_params('iface_create', $params);

    return $self->client->call_rpc( "iface.create", $params );
}

=head1 update

Updates network interface attributes.

=cut

sub update {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef' }
    );

    carp 'Required parameter id is not defined' if ( ! $self->id );
    _validated_params('iface_update', $params);

    return $self->client->call_rpc( "iface.update", $self->id, $params );
}

=head1 delete

Deletes a network interface.

=cut

sub delete {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc('iface.delete', $self->id);
}

1;
