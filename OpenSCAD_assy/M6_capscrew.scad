// M6 capscrew
shank_dia = 6.0;
head_dia = 10.0;
head_h = 6.0;
hex_dia = 5;
hex_h = 5;

module M6_capscrew(len) {
    color("grey") difference() {
        union() {
            cylinder(d=shank_dia, h=len);
            translate([0,0,len]) cylinder(d=head_dia, h=head_h);
        }
        translate([0,0,len+head_h-hex_h]) cylinder(d=hex_dia, h=hex_h,$fn=6);
    }
}
           
M6_capscrew(20);