include <project.scad>
use <helpers.scad>
use <bearing.scad>
use <housing.scad>
use <insert.scad>
use <M6_capscrew.scad>

bearing_housing();
translate([0,0, housing_h - bearing_h]) bearing();
translate([0,0, housing_h-insert_h]) pcd(8, insert_pcd) insert();
translate([0,0, boss_flange_thk-20]) grid(boss_holes, 2, 2, center=true) M6_capscrew(20);
