include <project.scad>

module insert() {
    color("gold") difference() {
        union() {
            cylinder(d=5.9, h=insert_h);
        }
        cylinder(d=4, h=insert_h+hole_eps);
    }
}

insert();

