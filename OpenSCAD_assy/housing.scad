include <project.scad>
use <helpers.scad>

module bearing_housing() {
    boss_size = [60, 60, 10];
    boss_rad = 5;
    cyl_dia = 50;
    cyl_h = 35;
    thru_dia = 20;
    cap_pcd = 37.5;
    cap_n = 8;
    M6_clearance = 6.5;
    M4_insert_h = 8;
    M4_insert_d = 5.9;
    flange_thk = 2;
    flange_dia = 25;
    
    color ("silver") difference() {
        union() {
            roundedRect(boss_size, boss_rad);
            cylinder(h=cyl_h, d=cyl_dia);
        }
        cylinder(h=housing_h,d=thru_dia);
        translate([0,0,housing_h - flange_thk]) cylinder(h=flange_thk+hole_eps, d=flange_dia);
        pcd(cap_n, cap_pcd) translate([0,0,housing_h-M4_insert_h]) cylinder(d=M4_insert_d, h=M4_insert_h+hole_eps);
        grid(boss_holes, 2, 2, center=true) cylinder(d=M6_clearance, h=boss_size.z+hole_eps);
    }
}

bearing_housing();