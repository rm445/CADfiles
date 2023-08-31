$fn = 50;

ro = 6;
ri = 5;
ctr_dist = 60;
box_height = 10;

lid_thk = 0.8;
lap_thk = 0.4;

module potting_box() {
    difference() {
        union() {
            //cube([60, 12, 12]);
            hull() {
                cylinder(box_height, r=ro);
                translate([ctr_dist, 0, 0]) cylinder(box_height, r=ro);
            }
            
            
        }   
        //translate([7.75, 80-19-25]) square([71.5, 25]); // screen
        // inner cut-out
        translate([0, 0, 1]) hull() {
            cylinder(100, r=ri);
            translate([ctr_dist, 0, 0]) cylinder(100, r=ri);
        }
        // cut slot as one big slit
        translate([-20, -0.75, 5]) cube([100, 1.5, 100], center=false);
    }
}

module lid() {
    union() {
        hull() {
            cylinder(lid_thk, r=ro);
            translate([ctr_dist, 0, 0]) cylinder(lid_thk, r=ro);
        }
        hull() {
            cylinder(lid_thk+lap_thk, r=ri-0.3);
            translate([ctr_dist, 0, 0]) cylinder(lid_thk+lap_thk, r=ri-0.3);
        }
        
    }
}

potting_box();
translate([0,0,box_height+lid_thk]) rotate([180, 0, 0]) lid();