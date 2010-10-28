package Net::Gandi::Hosting::Disk;

use Moose;

extends 'Net::Gandi';

=head1 NAME

Net::Gandi::Hosting::Disk - Interface to manage Disk. 

=head1 DESCRIPTION

A disk represents a virtual storage device you can attached to a VM. It then behaves like a block device where you can read and write data.

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

=head1 disk_list 

List the disks associated with apikey that match the filter.

Available params are: 

=over 

=item * 

id 

=item * 

state 

=item * 

size

=item * 

name

=item * 

type

=item * 

vm_id

=item * 

datacenter_id

=item * 

items_per_page

=item * 

page

=item * 

sort_by

=back

=cut

sub disk_list {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc( "disk.list", $params );
}

=head1 disk_count

Returns the number of VMs associated with apikey, matched by filters, if specified.

Available params are: 

=over 

=item * 

id

=item * 

state

=item * 

size

=item * 

name

=item * 

type

=item * 

vm_id

=item * 

datacenter_id

=back

=cut

sub disk_count {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc('disk.count', $params);
}

=head1 disk_info

Return a mapping of the disk attributes.

Parameter: None

=cut 

sub disk_info {
    my ( $self ) = @_;

    return $self->call_rpc( 'disk.info', $self->id );
}

=head1 disk_get_options

Returns available kernels and kernel options for this disk.

Parameter: None

=cut 

sub disk_get_options {
    my ( $self ) = @_;

    return $self->call_rpc( 'disk.get_options', $self->id );
}

=head1 disk_create

Create a disk.

=cut

sub disk_create {
    my ( $self, $params ) = @_;

    return $self->call_rpc( "disk.create", $params );
}

=head1 disk_create_from

Create a disk with the same data as the disk identified by src_disk_id.

=cut

sub disk_create_from {
    my ( $self, $params, $src_disk_id ) = @_;

    return $self->call_rpc( "disk.create", $params, $src_disk_id );
}

=head1 disk_update

Update the disk to match the expected attributes.

=cut

sub disk_update {
    my ( $self, $params ) = @_;

    return $self->call_rpc('disk.update', $self->id, $params);
}

=head1 disk_delete

Delete a disk. Warning, erase data. Free the quota used by the disk size.

=cut

sub disk_delete {
    my ( $self ) = @_;

    return $self->call_rpc('disk.delete', $self->id);
}

=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>

=cut

1;
