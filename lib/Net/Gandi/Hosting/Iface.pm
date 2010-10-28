package Net::Gandi::Hosting::Iface;

use Moose;

extends 'Net::Gandi';

=head1 NAME

Net::Gandi::Hosting::Iface - Interface to manage Iface. 

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

=head1 iface_list 

List network interfaces associated to apikey that match the filter.

Available params are: 

=over 

=item id 
=item state 
=item type
=item vm_id
=item items_per_page
=item page
=item sort_by

=back

=cut

sub iface_list {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc( "iface.list", $params );
}

=head1 iface_count

Count network interfaces associated to apikey that match the filter

Available params are: 

=over 

=item id 
=item state 
=item type
=item vm_id

=back

=cut

sub iface_count {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc('iface.count', $params);
}

=head1 iface_info

Returns informations about the network interface

=cut 

sub iface_info {
    my ( $self ) = @_;

    return $self->call_rpc( 'iface.info', $self->id );
}

=head1 iface_create

Create a iface.

=cut

sub iface_create {
    my ( $self, $params ) = @_;

    return $self->call_rpc( "iface.create", $params );
}

=head1 iface_update

Updates network interface’s attributes.

=cut

sub iface_update {
    my ( $self, $params ) = @_;

    return $self->call_rpc( "iface.update", $self->id, $params );
}

=head1

Deletes a network interface.

=cut

sub iface_delete {
    my ( $self ) = @_;

    return $self->call_rpc('iface.delete', $self->id);
}

=head1 DESCRIPTION

A iface represent a network interface.

=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>

=cut

1;
