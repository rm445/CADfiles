
housing_h = 35;
bearing_h  = 20;
insert_h = 8;
insert_pcd = 37.5;

hole_eps = 0.02;
hole_start_eps = 0.01;

boss_holes = [50, 50];
boss_flange_thk = 10;

module thru_hole() {
    translate([0, 0, -hole_start_eps]) children();
}