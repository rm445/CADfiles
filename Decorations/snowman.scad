$fn = 80;

module arm() {
    square([10, 1.3]);
    translate([10, 0]) rotate([0, 0, 30]) square([6.2, 1.0]);
    translate([10, 0]) rotate([0, 0, -30]) square([5, 1.2]);
    translate([10, 0.5]) rotate([0, 0, -5]) square([5, 1]);
}

module ring() {
    difference() {
        circle(r=20);
        circle(r=18.5);
    }
}

module tab() {
    difference() {
        union() {
            translate([0, 2.5]) circle(r=2.5, center=true);
            square(5, center=true);
        }
        translate([0, 2.5]) circle(r=1.4);
    }
}

module blob(r) {
    difference() {
        scale([1, 1, 0.7]) sphere(r=r);
        translate([0, 0, -r]) cube([3*r, 3*r, 2*r], center=true);
    }
}

module outline() {
    translate([0, 30]) tab();
    translate([0, 26])
        square([8, 6], center=true); //hat      
    translate([0, 22])
        square([16, 2], center=true); //brim  
    translate([0, 19])
        scale([1, 0.9])
            circle(6); //head
    translate([0, 10])
        scale([1, 0.8])
            circle(8); // torso
    translate([4.5,10]) 
        rotate([0,0, -5])
            arm(); // his left
    translate([-4.5,12]) 
        rotate([0,0, 195])
            arm(); // his right
    scale([1, 0.88]) 
        circle(10); // legs
    translate([0, 10.2])
        ring();
}

thk = 1.2;
btn = 1.2;
color("white") linear_extrude(thk) outline();
color("black") translate([0, 11.6, thk]) blob(btn); //buttons
color("black") translate([0, 7.1, thk]) blob(btn);
color("black") translate([0, 2.6, thk]) blob(btn);
color("black") translate([2, 19, thk]) blob(0.7); //eyes
color("black") translate([-2, 19, thk]) blob(0.7); //eyes
color("orange") translate([0, 17, thk]) cylinder(2.3, 1.1, 0.2);