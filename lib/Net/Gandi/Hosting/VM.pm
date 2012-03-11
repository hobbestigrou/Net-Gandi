package Net::Gandi::Hosting::VM;

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
    return $self->client->call_rpc( "vm.list", $params );
}

sub count {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->client->call_rpc('vm.count', $params);
}

sub info {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc( 'vm.info', $self->id );
}

sub create {
    my ( $self, $params ) = @_;

    foreach my $param ( 'hostname', 'password' ) {
        $params->{$param} = XMLRPC::Data->type('string')->value($params->{$param});
    }

    return $self->client->call_rpc( "vm.create", $params );
}

sub create_from {
    my ( $self, $params, $disk_params, $src_disk_id ) = @_;

    foreach my $param ( 'hostname', 'password' ) {
        $params->{$param} = XMLRPC::Data
            ->type('string')
            ->value($params->{$param});
    }

    return $self->client->call_rpc( "vm.create_from", $params, $disk_params, $src_disk_id );
}

sub update {
    my ( $self, $params ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );

    $params ||= {};
    return $self->client->call_rpc('vm.update', $self->id, $params);
}

sub disk_attach {
    my ( $self, $disk_id, $params ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );

    if ( $params ) {
        return $self->client->call_rpc('vm.disk_attach', $self->id, $disk_id, $params);
    }
    else {
        return $self->client->call_rpc('vm.disk_attach', $self->id, $disk_id);
    }
}

sub disk_detach {
    my ( $self, $disk_id ) = @_;


    carp 'Required parameter id is not defined' if ( ! $self->id );

    return $self->client->call_rpc('vm.disk_detach', $self->id, $disk_id);
}


=head1 start

Starts a VM and return the corresponding operation
Parameter: None

=cut

sub start {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc('vm.start', $self->id);
}

=head1 stop

Stops a VM and returns the corresponding operation.
Parameter: None

=cut

sub stop {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc('vm.stop', $self->id);
}

=head1 reboot

Reboots a VM and returns the corresponding operation
Parameter: None

=cut

sub reboot {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc('vm.reboot', $self->id);
}

=head1

Deletes a VM. Deletes the disk attached in position 0, the disk used as system disk.
Also deletes the first network interface. Detach all extra disks and network interfaces.
Parameter: None

=cut

sub delete {
    my ( $self ) = @_;

    carp 'Required parameter id is not defined' if ( ! $self->id );
    return $self->client->call_rpc('vm.delete', $self->id);
}

1;
