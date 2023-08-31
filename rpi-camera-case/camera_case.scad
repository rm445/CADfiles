use <../helpers.scad>
use <rpi.scad>
include<rpi_h.scad>


// Front of case
// Default orientation is upwards with mating face of camera
// PCB on z=0
$fn=100;
module case_front() {
    rad=3;
    ht = 10;
    color("yellow")  {
        //First part: body
        difference() {  
            hull() {
                
                translate([0, -1, 0])
                  grid([(32-2*rad), 35-2*rad], 2, 2, center=true)
                    cylinder(r=rad, h=ht);
                translate([0, 22.5-rad, 0])
                  grid([10-2*rad, 0], 2, 1, center=true)
                    cylinder(r=rad, h=ht);
            }
            cube([9, 9, 10*ht], center=true); //camera
            translate([0, -14.5, 1])
              grid([24, 0], 2, 1, center=true)
                cylinder(d=5, h=2*ht); // inserts
            translate([0, 18.5, 1]) cylinder(d=5, h=2*ht); // top insert
            //#translate([0, -14.5, 0])
            //  grid([24, 0], 2, 1, center=true)
            //    cylinder(d=8, h=2*ht); // check
            //#translate([0, 18.5, 0]) cylinder(d=8, h=2*ht); // check
            translate([0, 2, ht/2+5]) cube([27, 26, ht], center=true);
            translate([0, 2, ht/2+3]) cube([16, 25, ht], center=true);
            translate([0,-15, ht/2+5]) cube([17.5, 30, ht], center=true);
            translate([cam_holes_offset.x, cam_holes_offset.y, 2]) grid(cam_holes, 2, 2) cylinder(d=2.5, h=10);
        }        
        // Second part: hinge
        difference() {
            union() {
                translate([0, -26.25, 2.5]) cube([24, 15.5, 5], center=true);
                translate([0, -14-14, 3]) cube([24, 12, 6], center=true);
                translate([0, -28, 6])
                  rotate([0, 90, 0])
                    cylinder(d=12, h=24, center=true);
            }
            translate([0, -28, 6])
              rotate([0, 90, 0])
                cylinder(d=5.9, h=30, center=true);
            translate([0, -28, 0]) cube([8, 12, 30], center=true);
            //translate([0, -26.5, 0]) cylinder(d=8, h=30, center=true);
            translate([0, -28, 0]) rounded_rect_plate([8, 19, 30], rad, center=true);
        }
        
    }
}

module case_hinge() {
    rad = 3;
    wid = 7.5;
    color("yellow") difference() {
        union() {
            rotate([0, 90, 0]) cylinder(d=12, h=wid, center=true);
            translate([0, -6, -3]) cube([wid, 12, 6], center=true);
            translate([0, -wid, -4]) cube([wid+2*rad, 3, 4], center=true);
            translate([0, -22, -4])
              rounded_rect_plate([30, 26, 4], rad, center=true); 
            //  hull() 
            //    grid([24, 20], 2, 2, center=true)
            //      cylinder(r=rad, h=4, center=true);
            translate([-wid/2, -1.1, 0])  cube([wid, 1.1, 6]);
            translate([-wid/2, -23.1, -2]) prism(wid, 22, 8.0);          
        }
        //subtract
        rotate([0, 90, 0]) cylinder(d=6, h=20, center=true);
        translate([0, -22, 0])
          grid([20, 16], 2, 2, center=true)
            cylinder(d=4.5, h=30, center=true);
        translate([(wid+2*rad)/2, -6, 0]) cylinder(r=rad, h=20, center=true);
        translate([-(wid+2*rad)/2, -6, 0]) cylinder(r=rad, h=20, center=true);
    }
}

module m3_csk_thru() {
    // 45 deg: 3.8 -> 6.3 = 2.5. 2.5 / 2 = 1.25
    union() {
        translate([0, 0, 3.25]) cylinder(d1=3.58, d2=6.6, h=1.25);
        translate([0, 0, 4.4]) cylinder(d=6, h=1);
        cylinder(d=3.5, h=10, center=true);
    }
}

module case_lid() {
    ht=4.5;
    rad = 3;
    color("yellow")  difference() {
        hull() { 
            translate([0, -1, 0])
              grid([(32-2*rad), 35-2*rad], 2, 2, center=true)
                cylinder(r=rad, h=ht);
            translate([0, 22.5-rad, 0])
              grid([10-2*rad, 0], 2, 1, center=true)
                cylinder(r=rad, h=ht);
        }
        translate([0, -14.5, 0])
          grid([24, 0], 2, 1, center=true) m3_csk_thru(); // inserts
        translate([0, 18.5, 0]) m3_csk_thru();
        //translate([cylinder(d1=3.5, d2=6, h=1.25);
    }        
}

module section() {
    difference() {
        assemble();
        translate([-100, 0, 0]) cube([200, 200, 200], center=true);
    }
}

module assemble(with_pi=false) {
    translate([0, 0, -5]) case_front();
    translate([0, -28, 1]) case_hinge();
    rotate([0, 180, 0]) camera1_3();
    translate([0, 0, 5]) case_lid();
    if(with_pi) {
        translate([0, -105, 0]) rotate([0,0,90]) rotate([90, 0, 0]) rpi();
    }
}


assemble();

// Individual parts
//case_front();
//case_lid();
//case_hinge();

// Section views
//section();