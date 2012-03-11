package Net::Gandi::Hosting::Disk;

use Moose;
use Net::Gandi::Types Client => { -as => 'Client_T' };

use Carp;

has 'id' => ( is => 'rw', isa => 'Int' );

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

sub list {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->client->call_rpc( "disk.list", $params );
}

sub count {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->client->call_rpc('disk.count', $params);
}

=head1 info

Return a mapping of the disk attributes.

Parameter: None

=cut 

sub info {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );

    return $self->client->call_rpc( 'disk.info', $self->id );
}

=head1 get_options

Returns available kernels and kernel options for this disk.

Parameter: None

=cut 

sub get_options {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc( 'disk.get_options', $self->id );
}

=head1 create

Create a disk.

=cut

sub create {
    my ( $self, $params ) = @_;

    return $self->client->call_rpc( "disk.create", $params );
}

=head1 create_from

Create a disk with the same data as the disk identified by src_disk_id.

=cut

sub create_from {
    my ( $self, $params, $src_disk_id ) = @_;

    return $self->client->call_rpc( "disk.create", $params, $src_disk_id );
}

=head1 update

Update the disk to match the expected attributes.

=cut

sub update {
    my ( $self, $params ) = @_;


    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc('disk.update', $self->id, $params);
}

=head1 delete

Delete a disk. Warning, erase data. Free the quota used by the disk size.

=cut

sub delete {
    my ( $self ) = @_;


    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc('disk.delete', $self->id);
}

=head1 attach

Attach a disk to a VM. 
The account associated with apikey MUST own both VM and disk.
A disk can only be attached to one VM.

Params: vm_id

=cut

sub attach {
    my ( $self, $vm_id, $params ) = @_;

    carp 'Required parameter id is not defined' if ( ! $vm_id );
    carp 'Required parameter id is not defined' if ( ! $self->id );

    if ( $params ) {
        return $self->client->call_rpc('vm.disk_attach', $vm_id, $self->id, $params);
    }
    else {
        return $self->client->call_rpc('vm.disk_attach', $vm_id, $self->id);
    }
}

=head1 detach

Detach a disk from a VM. The disk MUST not be mounted on the VM. If the disk position is 0, the VM MUST be halted to detach the disk

Params: vm_id

=cut

sub detach {
    my ( $self, $vm_id ) = @_;

    carp 'Required parameter id is not defined' if ( ! $vm_id );
    carp 'Required parameter id is not defined' if ( ! $self->id );

    return $self->client->call_rpc('vm.disk_detach', $vm_id, $self->id);
}

1;
