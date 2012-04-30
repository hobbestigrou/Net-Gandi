package Net::Gandi::Hosting::VM;

# ABSTRACT: Vm interface

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

=method list

  $vm->list;

List virtual machines.

  input: opts (HashRef) : Filtering options
  output: (HashRef)     : List of vm

=cut

sub list {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->call_rpc( "vm.list", $params );
}

=method count

  $vm->count;

Count virtual machines.

  input: opts (HashRef) : Filtering options
  output: (Int)         : count of vm

=cut

sub count {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->call_rpc('vm.count', $params);
}

=method info

  $vm->info

Get information about a virtual machine.

  input: None
  output: (HashRef) : Vm informations

=cut

sub info {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc( 'vm.info', $self->id );
}

=method create
Create a new virtual machine with respect to the attributes specified by vm_spec.
Disk, iface, and vm must be in the same datacenter.

  input: vm_spec (HashRef)   : specifications of the VM to create
  output: (ArrayRef)         : Operation vm create and iface create

=cut

sub create {
    my ( $self, $params ) = validated_list(
        \@_,
        vm_spec => { isa => 'HashRef' }
    );

    _validated_params('vm_create', $params);

    foreach my $param ( 'hostname', 'password' ) {
        $params->{$param} = XMLRPC::Data->type('string')->value($params->{$param});
    }

    return $self->client->call_rpc( "vm.create", $params );
}

=method create_from

Create a disk and a virtual machine.
This is a convenient method to do the disk.create and vm.create in a single API call.

  input: vm_spec (HashRef)   : specifications of the VM to create
         disk_spec (HashRef) : specifications of the Disk to create
         src_disk_id (Int)   : source disk unique identifier
  output: (ArrayRef)         : Operation vm create, disk create, and iface create

=cut

sub create_from {
    my ( $self, $params, $disk_spec, $src_disk_id ) = validated_list(
        \@_,
        vm_spec     => { isa => 'HashRef' },
        disk_spec   => { isa => 'HashRef' },
        src_disk_id => { isa => 'Int' }
    );

    _validated_params('vm_create_from', $params);

    foreach my $param ( 'hostname', 'password' ) {
        $params->{$param} = XMLRPC::Data
            ->type('string')
            ->value($params->{$param});
    }

    return $self->client->call_rpc( "vm.create_from", $params, $disk_spec, $src_disk_id );
}

=method update

  $vm->update;

Update a virtual machine with respect to the attributes specified by update_spec.

  input: update_spec (HashRef) : specifications of the virtual machine to update
  output: (HashRef)  : Vm update operation

=cut

sub update {
    my ( $self, $params ) = validated_list(
        \@_,
        update_spec => { isa => 'HashRef' }
    );

    carp 'Required parameter id is not defined' if ( ! $self->id );

    $params ||= {};
    return $self->client->call_rpc('vm.update', $self->id, $params);
}

=method disk_attach

Attach a disk to a virtual machine.
To access the disk data inside the VM, it MUST be attached to the VM.
When options.position is 0, swaps position with current disk 0.
A disk can be attached to only one VM.

=cut

sub disk_attach {
    my ( $self, $disk_id, $params ) = validated_list(
        \@_,
        disk_id => { isa => 'Int'},
        opts    => { isa => 'HashRef' }
    );

    carp 'Required parameter id is not defined' if ( ! $self->id );

    if ( $params ) {
        return $self->client->call_rpc('vm.disk_attach', $self->id, $disk_id, $params);
    }
    else {
        return $self->client->call_rpc('vm.disk_attach', $self->id, $disk_id);
    }
}

=method disk_detach

Detach a disk from a virtual machine.
If the disk position is 0, i.e. the system disk, the virtual machine must be halted to detach the disk.

=cut

sub disk_detach {
    my ( $self, $disk_id ) = validated_list(
        \@_,
        disk_id => { isa => 'Int'}
    );


    carp 'Required parameter id is not defined' if ( ! $self->id );

    return $self->client->call_rpc('vm.disk_detach', $self->id, $disk_id);
}


=method start

Starts a VM and return the corresponding operation
Parameter: None

=cut

sub start {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc('vm.start', $self->id);
}

=method stop

Stops a VM and returns the corresponding operation.

  input: None
  output: (HashRef): Operation vm stop

=cut

sub stop {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc('vm.stop', $self->id);
}

=method reboot

Reboots a VM and returns the corresponding operation

  input: None
  output: (HashRef): operation vm reboot

=cut

sub reboot {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc('vm.reboot', $self->id);
}

=method delete

Deletes a VM. Deletes the disk attached in position 0, the disk used as system disk.
Also deletes the first network interface. Detach all extra disks and network interfaces.

  input: None
  output: (HashRef): Operation vm delete

=cut

sub delete {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc('vm.delete', $self->id);
}

1;
