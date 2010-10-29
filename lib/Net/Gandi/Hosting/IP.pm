package Net::Gandi::Hosting::IP;

use Moose;
use utf8;

extends 'Net::Gandi';


=head1 NAME

Net::Gandi::Hosting::IP - Interface to manage IP. 

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

=head1 list

List IP associated with apikey that match the filter

=cut

sub list {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc( 'ip.list', $params );
}

=head1 count 

List IP associated with apikey that match the filter

=cut

sub count {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc('ip.count', $params);
}

=head1 info

Return a mapping of the IP attributes.

Parameter: None

=cut 

sub info {
    my ( $self ) = @_;

    return $self->call_rpc( 'ip.info', $self->id );
}

=head1 update

Updates a IP’s attributes

=cut

sub update {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc('ip.update', $self->id, $params);
}

#sub attach {
#    my ( $self, $iface_id ) = @_;
#
#    return $self->call_rpc('iface.attach', $iface_id, $self->id);
#}


#sub detach {
#    my ( $self, $iface_id ) = @_;
#
#    return $self->call_rpc('iface.detach', $iface_id, $self->id);
#}

=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>

=cut

1;
