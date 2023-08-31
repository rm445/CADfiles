// 60.5 x 31.6 (corners R 1.5) x 94 lng (not chamfered) 

use <../helpers.scad>
include <rpi_h.scad>


// Raspberry Pi 3 B in aluminium case
module rpi_case() {
    color("#404040") difference()  {
        union() {
            rounded_rect_plate([rpi_w, rpi_h, rpi_l], 
              1.5, center=true);
        }
        //subtract
        rounded_rect_plate([rpi_w-3, rpi_h-3, rpi_l-3], 
                            1.5, center=true);
        // USB ports
        translate([rpi_USB.x-rpi_w/2, rpi_USB.y-rpi_h/2,
                   rpi_l/2-2])
          cube([USB_A_zone.x, USB_A_zone.y, 3]);
        // Top holes
        rotate([-90, 0, 0])
          grid([50, 70], 13, 13, center=true)
            cylinder(d=1.5, h=100, $fn=20);
        // Micro USB power  
        rotate([0, -90, 0])
          translate([rpi_power_coords.x-rpi_l/2,
                     rpi_power_coords.y-rpi_h/2, 
                     rpi_w/2-5] )
            cube([micro_USB.x, micro_USB.y, 10]);
        // GPIO slot
        rotate([0, 90, 0]) 
          translate([0, 0, 50])
            cube([50, 2, 100], center=true);
        
    }
    /*color("silver")
      translate([rpi_USB.x-rpi_w/2, rpi_USB.y-rpi_h/2, rpi_l/2])
        cube([USB_A_zone.x, USB_A_zone.y, 0.1]); */
    color("silver")
      rotate([0, -90, 0])
        translate([rpi_power_coords.x-rpi_l/2,
                   rpi_power_coords.y-rpi_h/2, 
                   rpi_w/2-1])
          cube([micro_USB.x, micro_USB.y, 0.1]);
    color("silver")
      translate([rpi_USB.x-rpi_w/2, rpi_USB.y-rpi_h/2,
                 rpi_l/2-2-1])
          cube([USB_A_zone.x, USB_A_zone.y, 0.1]);
}

// Raspberry Pi Camera Rev 1.3
// Origin is at the centre of the camera lens, on the upper face
// of the PCB (i.e. where it sits flat against its mounts).
$fn=50;
module camera1_3() {
    color("green") difference() {
        translate([-12.5, -10, -1])
          cube([25, 24, 1.0], center=false);
        translate([cam_holes_offset.x, cam_holes_offset.y, -1])
          grid([cam_holes.x, cam_holes.y], 2, 2, center=false)
            hole_thru(2, 1, $fn=30);
    }
    color("black") translate([-4, -4, 0]) cube([8, 8, 4]);
    color("black") difference() {
        translate([0, 0, 4]) cylinder(d=8, h=1);
        translate([0, 0, 4]) cylinder(d=2, h=1.1);
    }
    color("grey") translate([0, 0, 4]) cylinder(d=2, h=0.8);
    color("white") translate([-6, +2, 0]) rotate([0,0,-90]) 
      text("Raspberry Pi Camera", size=1.5, halign="center");
    color("white") translate([-8, +2, 0]) rotate([0,0,-90]) 
      text("Rev 1.3", size=1.5, halign="center");
    color("white") translate([-8, -75, -1]) 
      cube([16, 65, 0.15]);
}

module section() {
    difference() {
        rpi_case();
        translate([100,0,0]) cube([200, 200, 200], center=true);
    }
}

module rpi_assemble() {
    rotate([90, 0, 0]) rpi_case();
    translate([100, 0, 0]) rotate([0, 0, -90]) camera1_3();
}

rpi_assemble();

//camera1_3();    
//rpi_case();
//section();