include <project.scad>

bearing_od = 20;
bearing_id = 18;
flange_d = 24.9;
flange_thk = 2;


module bearing() {
        color("blue") difference() {
            union() {
                cylinder(d=bearing_od, h=bearing_h);
                translate([0, 0, bearing_h - flange_thk]) cylinder(d=flange_d, h=flange_thk);
            }
            thru_hole() cylinder(d=bearing_id, h=bearing_h+hole_eps);
        }
}

bearing();