// Helper functions

hole_eps = 0.02;
hole_start = 0.01;

module rounded_rect_plate(size, radius, center=false) {
    zoffs = center == true ? -size.z/2 : 0;
    translate([0, 0, zoffs])
      linear_extrude(size.z)
        rounded_rect([size.x, size.y], radius, center=center);
}

module rounded_rect(size, radius, center=false) {
    xmin = center == true ? -size.x/2 : 0;
    xmax = center == true ? size.x/2 : size.x;
    ymin = center == true ? -size.y/2 : 0;
    ymax = center == true ? size.y/2 : size.y;
    
    hull() {
        translate([xmin+(radius), (ymin)+(radius), 0])
          circle(r=radius);
        translate([(xmax)-(radius), (ymin)+(radius), 0])
          circle(r=radius);
        translate([(xmin)+(radius), (ymax)-(radius), 0])
          circle(r=radius);
        translate([(xmax)-(radius), (ymax)-(radius), 0])
          circle(r=radius);
    }
}   

module pcd(n, d) 
{
    angle = 360/n;
    for (i=[0:n-1]) {
        rotate([0,0,i*angle]) translate([d/2,0,0]) children();
    }
}

module grid(size, xn, yn, center=false)
{
    xmin = center == true ?  -0.5 * size[0] : 0;
    ymin = center == true ?  -0.5 * size[1] : 0;
    x_spacing = xn != 1 ? size[0] / (xn - 1) : 0;
    y_spacing = yn != 1 ? size[1] / (yn - 1) : 0;
    for (y = [0: yn - 1]) {
        for (x = [0: xn-1]) {
            translate([xmin+x*x_spacing, ymin + y*y_spacing, 0]) children();
        }
    }
}

module hole_thru(d, h, $fn=0) {
    translate([0, 0, -hole_start]) cylinder(d=d, h=h+hole_eps, $fn=$fn);
}

module slotter(ctrs, rotation=0) {
    hull() {
        rotate([0,0, rotation]) translate([ctrs/2, 0, 0]) children();
        rotate([0,0, rotation]) translate([-ctrs/2, 0, 0]) children();
    }
}

module slot(d, ctrs, rotation=0) {
    slotter(ctrs=ctrs, rotation=rotation) circle(d=d, $fn=20);
}

module slot_thru(d, ctrs, h, rotation=0, $fn=0) {
    slotter(ctrs=ctrs, rotation=rotation) hole_thru(d=d, h=h, $fn=$fn);
}

module reg_poly(d, n, rotation=0) {
    // regular polygon with base parallel to x-axis,
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

//slot_thru(d=5, ctrs=10, rotation=45, h=1, $fn=20);

//rounded_rect([30, 30], radius=5, center=true);



module prism(l, w, h) {
    polyhedron(
           points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
           );
}