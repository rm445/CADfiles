module roundedRect(size, radius)
{
    linear_extrude(height=size.z) hull() {
        // place 4 circles in the corners, with the given radius
        translate([(-size.x/2)+(radius/2), (-size.y/2)+(radius/2), 0])
          circle(r=radius);
        translate([(size.x/2)-(radius/2), (-size.y/2)+(radius/2), 0])
          circle(r=radius);
        translate([(-size.x/2)+(radius/2), (size.y/2)-(radius/2), 0])
          circle(r=radius);
        translate([(size.x/2)-(radius/2), (size.y/2)-(radius/2), 0])
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
    x_spacing = size[0] / (xn - 1);
    y_spacing = size[1] / (yn - 1);
    for (y = [0: yn - 1]) {
        for (x = [0: xn-1]) {
            translate([xmin+x*x_spacing, ymin + y*y_spacing, 0]) children();
        }
    }
}
