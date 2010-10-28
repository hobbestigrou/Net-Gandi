package Net::Gandi::Hosting::VM;

use Moose;

extends 'Net::Gandi';

=head1 NAME

Net::Gandi::Hosting::VM - Interface to manage VM. 

=head1 DESCRIPTION

A VM (Virtual Machine) describes a server’s resources and state.

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

=head1 vm_list 

Returns the list of VMs associated with apikey, matched by filters, if specified.

Available params are: 

=over 

=item *

id 

=item * 

memory

=item * 

state

=item * 

shares

=item * 

hostname

=item * 

cores

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

sub vm_list {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc( "vm.list", $params );
}

=head1 vm_count

Returns the number of VMs associated with apikey, matched by filters, if specified.

Available params are: 

=over 

=item * 

id 

=item * 

memory

=item * 

state

=item * 

shares

=item * 

hostname

=item * 

cores

=item * 

datacenter_id

=back

=cut

sub vm_count {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc('vm.count', $params);
}

=head1 vm_info

Return a mapping of the VM attributes.

Parameter: None

    use Net::Gandi;

    my $vm   = Net::Gandi::Hosting::VM->new( apikey => 'myapikey', id => 42 );
    my $info = $vm->vm_info;

=cut 

sub vm_info {
    my ( $self ) = @_;

    return $self->call_rpc( 'vm.info', $self->id );
}

=head1 vm_create

Creates a VM and returns the corresponding operations.

=cut

sub vm_create {
    my ( $self, $params ) = @_;

    foreach my $param ( 'hostname', 'password' ) {
        $params->{$param} = XMLRPC::Data->type('string')->value($params->{$param});
    }

    return $self->call_rpc( "vm.create", $params );
}

=head1 vm_create_from 

Creates a Disk, and then, a VM, and returns the corresponding operations.
It combines the API method disk.create, and vm.create.
This is a convenient method to do the disk.create and vm.create in a single API call.
Three operations are created and returned (in this order): disk_create, iface_create, vm_create

=cut

sub vm_create_from {
    my ( $self, $vm_params, $disk_params, $src_disk_id ) = @_;

    foreach my $param ( 'hostname', 'password' ) {
        $vm_params->{$param} = XMLRPC::Data
            ->type('string')
            ->value($vm_params->{$param});
    }

    return $self->call_rpc( "vm.create", $vm_params, $disk_params, $src_disk_id );
}

=head1 vm_update

Updates a VM.

=cut

sub vm_update {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc('vm.update', $self->id, $params);
}

=head1 vm_disk_attach

Attach a disk to a VM. 
The account associated with apikey MUST own both VM and disk.
A disk can only be attached to one VM.

=cut

sub vm_disk_attach {
    my ( $self, $disk_id, $params ) = @_;

    if ( $params ) {
        return $self->call_rpc('vm.disk_attach', $self->id, $disk_id, $params);
    }
    else {
        return $self->call_rpc('vm.disk_attach', $self->id, $disk_id);
    }
}

=head1 vm_disk_detach

Detach a disk from a VM. The disk MUST not be mounted on the VM. If the disk position is 0, the VM MUST be halted to detach the disk

Params: disk_id

=cut

sub vm_disk_detach {
    my ( $self, $disk_id ) = @_;

    return $self->call_rpc('vm.disk_attach', $self->id, $disk_id);
}

=head1 vm_start

Starts a VM and return the corresponding operation
Parameter: None

=cut

sub vm_start {
    my ( $self ) = @_;

    return $self->call_rpc('vm.start', $self->id);
}

=head1 vm_stop

Stops a VM and returns the corresponding operation.
Parameter: None

=cut

sub vm_stop {
    my ( $self ) = @_;

    return $self->call_rpc('vm.stop', $self->id);
}

=head1 vm_reboot

Reboots a VM and returns the corresponding operation
Parameter: None

=cut

sub vm_reboot {
    my ( $self ) = @_;

    return $self->call_rpc('vm.reboot', $self->id);
}

=head1

Deletes a VM. Deletes the disk attached in position 0, the disk used as system disk.
Also deletes the first network interface. Detach all extra disks and network interfaces.
Parameter: None

=cut

sub vm_delete {
    my ( $self ) = @_;

    return $self->call_rpc('vm.delete', $self->id);
}

=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>

=cut

1;
