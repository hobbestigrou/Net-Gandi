package Net::Gandi::Hosting::Iface;

use Moose;

extends 'Net::Gandi';

=head1 NAME

=encoding utf-8

Net::Gandi::Hosting::Iface - Interface to manage Iface. 

=head1 DESCRIPTION

A iface represent a network interface.

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

=head1 list 

List network interfaces associated to apikey that match the filter.

Available params are: 

=over 

=item *

id

=item *

state 

=item *

type

=item * 

vm_id

=item * 

items_per_page

=item *

page

=item * 

sort_by

=back

=cut

sub list {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc( "iface.list", $params );
}

=head1 count

Count network interfaces associated to apikey that match the filter

Available params are: 

=over 

=item * 

id 

=item * 

state 

=item * 

type

=item *

vm_id

=back

=cut

sub count {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc('iface.count', $params);
}

=head1 info

Returns informations about the network interface

=cut 

sub info {
    my ( $self ) = @_;

    return $self->call_rpc( 'iface.info', $self->id );
}

=head1 create

Create a iface.

=cut

sub create {
    my ( $self, $params ) = @_;

    return $self->call_rpc( "iface.create", $params );
}

=head1 update

Updates network interface attributes.

=cut

sub update {
    my ( $self, $params ) = @_;

    return $self->call_rpc( "iface.update", $self->id, $params );
}

=head1 delete

Deletes a network interface.

=cut

sub delete {
    my ( $self ) = @_;

    return $self->call_rpc('iface.delete', $self->id);
}

=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>

=cut

1;
