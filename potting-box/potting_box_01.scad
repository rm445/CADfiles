module potting_box() {
    difference() {
        union() {
            cube([60, 12, 12]);
            
            
        }   
        //translate([7.75, 80-19-25]) square([71.5, 25]); // screen
        translate([1, 1, 1]) cube ([58, 10, 100]);
        translate([-5, 5.25, 8]) cube([10, 1.5, 100]);
        translate([55, 5.25, 8]) cube([10, 1.5, 100]);
    }
}

potting_box();