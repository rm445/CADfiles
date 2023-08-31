//cylinder(d=8, h=5, $fn=5);
//cylinder(d=6, h=10, $fn=6);
//cylinder(d=5, h=15, $fn=8);

module layout_shapes() {
for (i=[3:12]) {
    translate([10*i,0,0]) cylinder(d=5, h=1, $fn=100);
    #translate([10*i,0,1]) linear_extrude(1) reg_poly(5, i);
    translate([10*i, 0, 2]) cylinder (d=circumscribed(5, i), h=1, $fn=200);
}
}

module reg_poly(d, n, rotation=0) {
    // regular polygon with base parallel to x-axis
    // diameter = circumscribed circle
    // for inscribed circle (equal to across-flats) use
    // d = inscribed(desired value)
    rot = n%2 == 0 ? 90+(180/n)+rotation : 90+rotation; 
    rotate([0,0,rot]) circle(d=d, $fn=n);
}

// The diameter of an inscribed circle of a polygon
//  specified by its circumscribed circle
function inscribed(d, n) = (d / sin(90*(n-2)/n));

// The diameter of an circumcribed circle of a polygon
//  specified by its inscribed circle
function circumscribed(d, n) = (d * sin(90*(n-2)/n));

layout_shapes();
for (i=[3:16]) {
    //echo(90*(i-2)/i);
    echo(circumscribed(5, i));
}