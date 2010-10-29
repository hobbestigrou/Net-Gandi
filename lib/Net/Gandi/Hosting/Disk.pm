package Net::Gandi::Hosting::Disk;

use Moose;
use utf8;

extends 'Net::Gandi';

=head1 NAME

Net::Gandi::Hosting::Disk - Interface to manage Disk. 

=head1 DESCRIPTION

A disk represents a virtual storage device you can attached to a VM. It then behaves like a block device where you can read and write data.

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

=head1 list 

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

sub list {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc( "disk.list", $params );
}

=head1 count

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

sub count {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc('disk.count', $params);
}

=head1 info

Return a mapping of the disk attributes.

Parameter: None

=cut 

sub info {
    my ( $self ) = @_;

    return $self->call_rpc( 'disk.info', $self->id );
}

=head1 get_options

Returns available kernels and kernel options for this disk.

Parameter: None

=cut 

sub get_options {
    my ( $self ) = @_;

    return $self->call_rpc( 'disk.get_options', $self->id );
}

=head1 create

Create a disk.

=cut

sub create {
    my ( $self, $params ) = @_;

    return $self->call_rpc( "disk.create", $params );
}

=head1 create_from

Create a disk with the same data as the disk identified by src_disk_id.

=cut

sub create_from {
    my ( $self, $params, $src_disk_id ) = @_;

    return $self->call_rpc( "disk.create", $params, $src_disk_id );
}

=head1 update

Update the disk to match the expected attributes.

=cut

sub update {
    my ( $self, $params ) = @_;

    return $self->call_rpc('disk.update', $self->id, $params);
}

=head1 delete

Delete a disk. Warning, erase data. Free the quota used by the disk size.

=cut

sub delete {
    my ( $self ) = @_;

    return $self->call_rpc('disk.delete', $self->id);
}

=head1 disk_attach

Attach a disk to a VM. 
The account associated with apikey MUST own both VM and disk.
A disk can only be attached to one VM.

Params: vm_id

=cut

sub disk_attach {
    my ( $self, $vm_id, $params ) = @_;

    if ( $params ) {
        return $self->call_rpc('vm.disk_attach', $vm_id, $self->id, $params);
    }
    else {
        return $self->call_rpc('vm.disk_attach', $vm_id, $self->id);
    }
}

=head1 disk_detach

Detach a disk from a VM. The disk MUST not be mounted on the VM. If the disk position is 0, the VM MUST be halted to detach the disk

Params: vm_id

=cut

sub disk_detach {
    my ( $self, $vm_id ) = @_;

    return $self->call_rpc('vm.disk_attach', $vm_id, $self->id);
}


=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>

=cut

1;
