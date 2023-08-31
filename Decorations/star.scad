$fn = 100;
base_thk = 2;

module ring() {
    difference() {
        circle(r=20);
        circle(r=18.5);
    }
}

module tri() {
   r = 12;
   ht = 9;
   xa = r * sin(36);
   ya = r * cos(36);
   polyhedron([ [0, 0, 0],
                [xa, ya, 0],
                [0, 40, 0],
                [-xa, ya, 0],
                [0, 0, ht] 
           ], faces = [[3, 0, 1, 2],
                       [0, 4, 1],
                       [0, 3, 4],
                       [1, 4, 2] ,
                       [2, 4, 3] ], convexity=10 );
}

module tribase() {
   r = 10;
   ht = 9;
   thk = 0.4;
   xa = r * sin(36);
   ya = r * cos(36);
   linear_extrude(base_thk) {
   polygon([ [0, 0],
                [xa, ya],
                [0, 40],
                [-xa, ya], 
           ], paths = [[3, 0, 1, 2]]);
   }
}


module star() {
    for (i = [0: 72: 359]) {
        rotate([0, 0, i]) tri();
    }
    
}

module starbase() {
    //linear_extrude(0.2) {
        for (i = [0: 72: 359]) {
            rotate([0, 0, i]) tribase();
        }
    //}
    
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


module frame() {
    difference() {
        union() {
            translate([-5, 39, 0]) cube([10, 7, 1]); //tab
            translate([0, 46, 0]) cylinder(h=1, r=5); //tab round
            cylinder(h=base_thk, r1=42, r2=40); //38); //basic ring
        }
        translate([0, 0, -1]) cylinder(h=10, r=39.3);
        //translate([0, 0, base_thk]) cylinder(h=2, r1=39.5, r2=40.5);
        translate([0, 46, -1]) cylinder(h=10, r=2.5); // tab hole
    }
}
//tri();
starbase();
translate([0, 0, base_thk]) star();
frame();