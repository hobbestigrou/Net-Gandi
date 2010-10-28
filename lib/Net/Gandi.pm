package Net::Gandi;

use Moose;
use XMLRPC::Lite;
use Carp;
use Net::Gandi::Hosting::VM;
use Net::Gandi::Hosting::Disk;
use Net::Gandi::Hosting::Image;
use Net::Gandi::Hosting::Iface;
use Net::Gandi::Hosting::IP;

=head1 NAME 

Net::Gandi - A perl interface to the Gandi XMLRPC API

=cut

our $VERSION = '0.1';

has 'apikey' => ( is       => 'rw', 
                  required => 1,
                  isa      => 'Str'
);

sub call_rpc {
    my ( $self, $method, @args ) = @_;
    
    my $url   = 'https://rpc.gandi.net/xmlrpc/2.0/';
    my $proxy = XMLRPC::Lite->proxy($url);
    my $api_response;

   eval {
       $api_response = $proxy->call($method, $self->apikey, @args);
   };

  if ( !$api_response ) {
      croak $@;
  }

 if ( $api_response->faultstring() ) {
     croak $api_response->faultstring();
 }

 return $api_response->result();
}

=head1 SYNOPSIS

    use Net::Gandi;

    my $gandi = Net::Gandi::Hosting::VM->new(apikey => 'myapikey', id => 42);

    my $vm_info = $gandi->vm_info;

=head1 DESCRIPTION

This module provides a Perl interface to the Gandi API. See l<http:://rpc.gandi.net>
for a full description of the Gandi API. For the moment, the API is in beta. You can
ask for a key via email. The interface can be changed.

=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>

=head1 CONTRIBUTING

This module is developed on Github at:

l<http://github.com/hobbestigrou/Net-Gandi> 

Feel free to fork the repo and submit pull requests

=head1 ACKNOWLEDGEMENTS

Franck Cuny and Michael Scherer for fix typo.
Gandi for API 

=head1 BUGS

Please report any bugs or feature requests in github.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.
  
    perldoc Net::Gandi

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Natal Ngétal.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=head1 SEE ALSO

L<Moose>
l<XMLRPC::Lite>
l<http:://rpc.gandi.net>

=cut

1;
