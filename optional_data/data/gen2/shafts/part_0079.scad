$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 25, 10 mm, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 10;                // step 3 length
total = 40;               // overall length
chamfer = 1;              // end chamfer
groove_r = 5;             // groove radius
groove_z = 32;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 1.3;           // groove depth
cross_d = 4;              // cross pin hole
cross_z = 5;              // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 10], [12.5, 10], [12.5, 30], [5, 30], [5, 39], [4, 40], [0, 40]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d1 + 4, d = cross_d, center = true);
}
