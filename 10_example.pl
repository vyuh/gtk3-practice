#!/usr/bin/perl
use strict;
use warnings;

use Gtk3 '-init';
use Glib 'TRUE', 'FALSE';

my @window = Gtk3::Window->new;
$window[0]->set_title("Hello World");

my @label = Gtk3::Label->new;
$label[0]->set_label("Click Here");
$label[0]->set_angle(25);
$label[0]->set_halign('end');

push @label, Gtk3::Label->new;
$label[1]->set_label("me too");
$label[1]->set_angle(-25);
$label[1]->set_halign('end');

my @button = Gtk3::Button->new;
$button[0]->add( $label[0] );
my @handler;
@handler =
  $button[0]
  ->signal_connect( clicked => sub { $| = 1; print "Hello World $handler[0]\n" }
  );

push @button, Gtk3::Button->new;
$button[1]->add( $label[1] );
push @handler,
  $button[1]
  ->signal_connect( clicked => sub { $| = 1; print "Handler $handler[1]\n" }
  );

my @dummy_button;
$dummy_button[$_] = Gtk3::Button->new_with_label("B $_") for 0 .. 5;

my @grid = Gtk3::Grid->new;
$grid[0]->add( $dummy_button[0] );
$grid[0]->attach( $dummy_button[1], 1, 0, 2, 1 );
$grid[0]->attach_next_to( $dummy_button[2], $dummy_button[0], 'bottom', 1, 2 );
$grid[0]->attach_next_to( $dummy_button[3], $dummy_button[2], 'right',  2, 1 );
$grid[0]->attach( $dummy_button[4], 1, 2, 1, 1 );
$grid[0]->attach_next_to( $dummy_button[5], $dummy_button[4], 'right', 1, 1 );

my $box = Gtk3::Box->new( 'vertical', 1 );
$box->pack_start( $button[0], 'TRUE', 'TRUE', 0 );
$box->pack_start( $grid[0],   'TRUE', 'TRUE', 0 );
$box->pack_end( $button[1], 'TRUE', 'TRUE', 0 );

$window[0]->add($box);
$window[0]->signal_connect( destroy => sub { Gtk3->main_quit } );

$window[0]->show_all;
Gtk3->main();
