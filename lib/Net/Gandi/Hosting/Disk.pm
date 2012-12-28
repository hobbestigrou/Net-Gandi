package Net::Gandi::Hosting::Disk;

# ABSTRACT: Disk interface

use Moose;
use MooseX::Params::Validate;
use namespace::autoclean;

use Net::Gandi::Types Client => { -as => 'Client_T' };
use Net::Gandi::Error;

use Carp;

=attr id

rw, Int. Id of the disk.

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

has client => (
    is       => 'rw',
    isa      => Client_T,
    required => 1,
);

=method list

  $disk->list;

List the disk.

  input: opts (HashRef) : Filtering options
  output: (HashRef)     : List of disk

=cut

sub list {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->api_call( "disk.list", $params );
}

=method count

  $disk->count;

Count disk.

  input: opts (HashRef) : Filtering options
  output: (Int)         : number of disk

=cut

sub count {
    my ( $self, $params ) = validated_list(
        \@_,
        opts => { isa => 'HashRef', optional => 1 }
    );

    $params ||= {};
    return $self->client->api_call('disk.count', $params);
}

=method info

Return a mapping of the disk attributes.

  input: None
  output: (HashRef) : Disk informations

=cut

sub info {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );

    return $self->client->api_call( 'disk.info', $self->id );
}

=method get_options

Returns available kernels and kernel options for this disk.

Parameter: None

=cut

sub get_options {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->api_call( 'disk.get_options', $self->id );
}

=method create

Create a disk.

  input: disk_spec (HashRef) : specifications of the Disk to create
  output: (HashRef)         : Operation disk create

=cut

sub create {
    my ( $self, $params ) = validated_list(
        \@_,
        disk_spec => { isa => 'HashRef', optional => 1 }
    );

    _validated_params('disk_create', $params);

    return $self->client->api_call( "disk.create", $params );
}

=method create_from

Create a disk with the same data as the disk identified by src_disk_id.

  input: disk_spec (HashRef) : specifications of the Disk to create
         src_disk_id (Int)   : source disk unique identifier
  output: (HashRef)         : Operation disk create

=cut

sub create_from {
    my ( $self, $params, $src_disk_id ) = validated_list(
        \@_,
        disk_spec   => { isa => 'HashRef', optional => 1 },
        src_disk_id => { isa => 'Int'}
    );

    _validated_params('disk_create_from', $params);

    return $self->client->api_call( "disk.create_from", $params, $src_disk_id );
}

=method update

Update the disk to match the expected attributes.

  input: update_spec (HashRef) : specifications of disk to update
  output: (HashRef)  : Disk update operation

=cut

sub update {
    my ( $self, $params ) = validated_list(
        \@_,
        disk_spec => { isa => 'HashRef', optional => 1 }
    );

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->api_call('disk.update', $self->id, $params);
}

=head1 delete

Delete a disk. Warning, erase data. Free the quota used by the disk size.

  input: None
  output: (HashRef): Operation disk delete

=cut

sub delete {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->api_call('disk.delete', $self->id);
}

=method attach

Attach a disk to a VM.
The account associated with apikey MUST own both VM and disk.
A disk can only be attached to one VM.

Params: vm_id

=cut

sub attach {
    my ( $self, $vm_id, $params ) = validated_list(
        \@_,
        vm_id => { isa => 'Int'},
        opts  => { isa => 'HashRef'},
    );

    carp 'Required parameter id is not defined' if ( ! $vm_id );
    carp 'Required parameter id is not defined' if ( ! $self->id );

    return $params
        ? $self->client->api_call('vm.disk_attach', $vm_id, $self->id, $params)
        : $self->client->api_call('vm.disk_attach', $vm_id, $self->id);
}

=method detach

Detach a disk from a VM. The disk MUST not be mounted on the VM. If the disk position is 0, the VM MUST be halted to detach the disk

Params: vm_id

=cut

sub detach {
    my ( $self, $vm_id ) = validated_list(
        \@_,
        vm_id => { isa => 'Int'}
    );

    carp 'Required parameter id is not defined' if ( ! $vm_id );
    carp 'Required parameter id is not defined' if ( ! $self->id );

    return $self->client->api_call('vm.disk_detach', $vm_id, $self->id);
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
