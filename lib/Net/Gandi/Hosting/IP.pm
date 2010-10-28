package Net::Gandi::Hosting::IP;

use Moose;

extends 'Net::Gandi';


=head1 NAME

Net::Gandi::Hosting::IP - Interface to manage IP. 

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

=head1 ip_list

List IP associated with apikey that match the filter

=cut

sub ip_list {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc( 'ip.list', $params );
}

=head1 ip_count 

List IP associated with apikey that match the filter

=cut

sub ip_count {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc('ip.count', $params);
}

=head1 ip_info

Return a mapping of the IP attributes.

Parameter: None

=cut 

sub ip_info {
    my ( $self ) = @_;

    return $self->call_rpc( 'ip.info', $self->id );
}

=head1 ip_update

Updates a IP’s attributes

=cut

sub ip_update {
    my ( $self, $params ) = @_;

    $params ||= {};
    return $self->call_rpc('ip.update', $self->id, $params);
}

#sub ip_attach {
#    my ( $self, $iface_id ) = @_;
#
#    return $self->call_rpc('iface.ip_attach', $iface_id, $self->id);
#}


#sub ip_detach {
#    my ( $self, $iface_id ) = @_;
#
#    return $self->call_rpc('iface.ip_detach', $iface_id, $self->id);
#}

=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>

=cut

1;
