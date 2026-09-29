$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 20 mm, 70 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 10;                // step 3 length
total = 70;               // overall length
chamfer = 2.5;            // end chamfer
groove_r = 10;            // groove radius
groove_z = 62;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1;             // groove depth
cross_d = 5;              // cross pin hole
cross_z = 20;             // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 40], [15, 40], [15, 60], [10, 60], [10, 67.5], [7.5, 70], [0, 70]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d1 + 4, d = cross_d, center = true);
}
