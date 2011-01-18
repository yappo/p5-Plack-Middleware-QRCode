package Plack::Middleware::QRCode;
use strict;
use warnings;
use parent qw(Plack::Middleware);
our $VERSION = '0.01';

use Plack::MIME;
use Plack::Request;
use Imager::QRCode;

use Plack::Util::Accessor qw( path type );

sub call {
    my($self, $env) = @_;

    my $req = Plack::Request->new($env);
    my $path = $self->path;
    if ($req->path =~ /$path/) {
        my $type = $self->type;
        my $content_type = Plack::MIME->mime_type("qr.$type") || 'text/plain';

        my $qr  = Imager::QRCode->new;
        my $img = $qr->plot($req->parameters->get('body'));
        $img->write( data => \my $data, type => $type );

        return [
            200,
            [
                'Content-Type'   => $content_type,
                'Content-Length' => length($data),
            ],
            [ $data ],
        ];
    }
    return $self->app->($env);
}


1;
__END__

=head1 NAME

Plack::Middleware::QRCode -

=head1 SYNOPSIS

  use Plack::Builder;
  use Plack::Middleware::QRCode;
  builder {
      enable 'QRCode',
          path => qr{^/qrcode}, type => 'png';
      $app;
  }

Request

  $ plackup -p 5000 app.psgi
  $ wget "http://localhost:5000/qrcode?body=foobar

=head1 DESCRIPTION

Plack::Middleware::QRCode is

=head1 AUTHOR

Kazuhiro Osawa E<lt>yappo {at} shibuya {dot} plE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
