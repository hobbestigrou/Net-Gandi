package Net::Gandi::Hosting::IP;

# ABSTRACT: Ip interface

use Moose;
use MooseX::Params::Validate;
use Net::Gandi::Types Client => { -as => 'Client_T' };

use Carp;

has 'id' => ( is => 'rw', isa => 'Int' );

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);


=head1 list

List IP associated with apikey that match the filter

=cut

sub list {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->call_rpc( 'ip.list', $params );
}

=head1 count 

List IP associated with apikey that match the filter

=cut

sub count {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->call_rpc('ip.count', $params);
}

=head1 info

Return a mapping of the IP attributes.

Parameter: None

=cut

sub info {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc( 'ip.info', $self->id );
}

=head1 update

Updates a IP’s attributes

=cut

sub update {
    my ( $self, $params ) = validated_list(
        \@_,
        ip_spec => { isa => 'HashRef' }
    );

    carp 'Required parameter id is not defined' if ( ! $self->id );

    $params ||= {};
    return $self->client->call_rpc('ip.update', $self->id, $params);
}

#sub attach {
#    my ( $self, $iface_id ) = @_;
#
#    return $self->client->call_rpc('iface.attach', $iface_id, $self->id);
#}


#sub detach {
#    my ( $self, $iface_id ) = @_;
#
#    return $self->client->call_rpc('iface.detach', $iface_id, $self->id);
#}

1;
